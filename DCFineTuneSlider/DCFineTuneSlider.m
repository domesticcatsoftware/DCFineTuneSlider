//
//  DCFineTuneSlider
//
//  Created by Patrick Richards on 27/05/11.
//  MIT License.
//
//  http://twitter.com/patr
//  http://domesticcat.com.au/projects
//  http://github.com/domesticcatsoftware/DCFineTuneSlider

#import "DCFineTuneSlider.h"

@interface DCFineTuneSlider()

- (void)setup;

@end

@implementation DCFineTuneSlider

@synthesize fineTuneAmount, increaseButton, decreaseButton, valueChangedHandler;

#pragma mark -

- (void)dealloc
{
	[increaseButton release];
	[decreaseButton release];
	[self setValueChangedHandler:nil];

	[super dealloc];
}

#pragma mark -
#pragma mark Init

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		[self setup];
	}

	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
		[self setup];
	}
	
	return self;
}

- (id)initWithFrame:(CGRect)frame decreaseButtonImage:(UIImage *)decreaseButtonImage increaseButtonImage:(UIImage *)increaseButtonImage fineTuneAmount:(CGFloat)aFineTuneAmount
{
	if ((self = [super initWithFrame:frame]))
	{
		[self setup];

		self.fineTuneAmount = aFineTuneAmount;
		[self.decreaseButton setImage:decreaseButtonImage forState:UIControlStateNormal];
		[self.increaseButton setImage:increaseButtonImage forState:UIControlStateNormal];
	}

	return self;
}

- (void)setup
{
	// UISlider's default min is 0.0 and max is 1.0, 0.1 for fine tuning seems about right
	self.fineTuneAmount = 0.1;

	// create the fine tune buttons, their frames are setup in layoutSubviews
	self.decreaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self addSubview:self.decreaseButton];
	[self.decreaseButton addTarget:self action:@selector(fineTuneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

	self.increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.increaseButton addTarget:self action:@selector(fineTuneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:self.increaseButton];

	// add the double tap to jump recognizer
	UITapGestureRecognizer *doubleTapGestureRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)] autorelease];
	doubleTapGestureRecognizer.numberOfTapsRequired = 2;
	doubleTapGestureRecognizer.cancelsTouchesInView = NO;
	doubleTapGestureRecognizer.delaysTouchesEnded = NO;
	[self addGestureRecognizer:doubleTapGestureRecognizer];
}

#pragma mark -
#pragma mark Layout

- (CGRect)trackRectForBounds:(CGRect)bounds
{
	// return a shortened track rect to account for the fine tune buttons
    CGRect result = [super trackRectForBounds:bounds];
    return CGRectInset(result, self.frame.size.height, 0.0);
}

- (void)layoutSubviews
{
	[super layoutSubviews];

	CGFloat buttonSize = self.frame.size.height;
	self.decreaseButton.frame = CGRectMake(0, 0, buttonSize, buttonSize);
	self.increaseButton.frame = CGRectMake(self.frame.size.width - buttonSize, 0, buttonSize, buttonSize);
}

#pragma mark -
#pragma mark Fine Tune Buttons

- (void)fineTuneButtonPressed:(id)sender
{
	if (sender == self.increaseButton)
		[self setValue:self.value + self.fineTuneAmount animated:YES];
	else if (sender == self.decreaseButton)
		[self setValue:self.value - self.fineTuneAmount animated:YES];

	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark -
#pragma mark Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGRect thumbRect = [self thumbRectForBounds:self.bounds trackRect:[self trackRectForBounds:self.bounds] value:self.value];
	CGPoint touchPoint = [[touches anyObject] locationInView:self];

	// check if the touch is inside the thumb of the slider
	if (CGRectContainsPoint(thumbRect, touchPoint))
	{
		fineTuning = NO;
		[super touchesBegan:touches withEvent:event];
	}
	else
	{
		fineTuning = YES;
		lastTouchPoint = touchPoint;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!fineTuning)
	{
		[super touchesMoved:touches withEvent:event];
		return;
	}

	CGRect thumbRect = [self thumbRectForBounds:self.bounds trackRect:[self trackRectForBounds:self.bounds] value:self.value];
	CGPoint touchPoint = [[touches anyObject] locationInView:self];

	if (touchPoint.x < CGRectGetMinX(thumbRect) && touchPoint.x < lastTouchPoint.x)
	{
		[self setValue:self.value - fineTuneAmount animated:YES];
	}
	else if (touchPoint.x > CGRectGetMaxX(thumbRect) && touchPoint.x > lastTouchPoint.x)
	{
		[self setValue:self.value + fineTuneAmount animated:YES];
	}

	[self sendActionsForControlEvents:UIControlEventValueChanged];

	lastTouchPoint = touchPoint;
}

- (void)doubleTap:(UITapGestureRecognizer *)gestureRecognizer
{
	CGPoint tapPoint = [gestureRecognizer locationInView:self];
	CGRect trackRect = [self trackRectForBounds:self.bounds];
	CGRect thumbRect = [self thumbRectForBounds:self.bounds trackRect:trackRect value:self.value];

	// check if it's on the thumb
	if (CGRectContainsPoint(thumbRect, tapPoint))
		return;

	// check if it's outside the track (with some leeway in the y direction)
	if (!CGRectContainsPoint(CGRectInset(trackRect, 0.0, -5.0), tapPoint))
		return;

	// calculate and set the new value
	CGFloat range = (self.maximumValue - self.minimumValue);
	CGFloat newValue = range * (tapPoint.x - CGRectGetMinX(trackRect)) / CGRectGetWidth(trackRect);
	[self setValue:newValue animated:YES];

	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark -
#pragma mark Block Support

- (void)setValue:(float)value
{
	[super setValue:value];

	// pass the value to the block if defined
	if (self.valueChangedHandler)
		self.valueChangedHandler(self);
}

- (void)setValue:(float)value animated:(BOOL)animated
{
	[super setValue:value animated:animated];

	// pass the value to the block if defined
	if (self.valueChangedHandler)
		self.valueChangedHandler(self);
}

@end
