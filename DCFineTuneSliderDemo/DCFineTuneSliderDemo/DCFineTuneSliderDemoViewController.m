//
//  DCFineTuneSliderDemoViewController.m
//  DCFineTuneSliderDemo
//
//  Created by Patrick Richards on 31/05/11.
//  Copyright 2011 Domestic Cat Software. All rights reserved.
//

#import "DCFineTuneSliderDemoViewController.h"
#import "DCFineTuneSlider.h"

@implementation DCFineTuneSliderDemoViewController
@synthesize slider, label;

- (void)dealloc
{
	[slider release];
	[label release];

	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self.slider.decreaseButton setImage:[UIImage imageNamed:@"chevron-rev~iphone"] forState:UIControlStateNormal];
	self.slider.decreaseButton.contentEdgeInsets = UIEdgeInsetsMake(1.0, 0, 0, 0);

	[self.slider.increaseButton setImage:[UIImage imageNamed:@"chevron~iphone"] forState:UIControlStateNormal];
	self.slider.increaseButton.contentEdgeInsets = UIEdgeInsetsMake(1.0, 0, 0, 0);

	self.slider.fineTuneAmount = .01;

	self.slider.valueChangedHandler = ^(id sender) {
		self.label.text = [NSString stringWithFormat:@"Value: %0.2f", [(UISlider *)sender value]];
	};

	[self.view addSubview:slider];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
