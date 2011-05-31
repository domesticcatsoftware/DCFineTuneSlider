//
//  DCFineTuneSliderDemoAppDelegate.h
//  DCFineTuneSliderDemo
//
//  Created by Patrick Richards on 31/05/11.
//  Copyright 2011 Domestic Cat Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCFineTuneSliderDemoViewController;

@interface DCFineTuneSliderDemoAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DCFineTuneSliderDemoViewController *viewController;

@end
