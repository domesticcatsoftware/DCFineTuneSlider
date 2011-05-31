//
//  DCFineTuneSlider
//
//  Created by Patrick Richards on 27/05/11.
//  MIT License.
//
//  http://twitter.com/patr
//  http://domesticcat.com.au/projects
//  http://github.com/domesticcatsoftware/DCFineTuneSlider

#import <UIKit/UIKit.h>

@interface DCFineTuneSlider : UISlider
{
	BOOL fineTuning;
	CGPoint lastTouchPoint;
}

@property CGFloat fineTuneAmount;
@property (nonatomic, retain) UIButton *increaseButton;
@property (nonatomic, retain) UIButton *decreaseButton;
@property (nonatomic, copy) void (^valueChangedHandler)(id sender);

//////////
// Init //
//////////

- (id)initWithCoder:(NSCoder *)aDecoder;
- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame decreaseButtonImage:(UIImage *)decreaseButtonImage increaseButtonImage:(UIImage *)increaseButtonImage fineTuneAmount:(CGFloat)aFineTuneAmount;

@end
