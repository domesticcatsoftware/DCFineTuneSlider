//
//  DCFineTuneSliderDemoAppDelegate.m
//  DCFineTuneSliderDemo
//
//  Created by Patrick Richards on 31/05/11.
//  Copyright 2011 Domestic Cat Software. All rights reserved.
//

#import "DCFineTuneSliderDemoAppDelegate.h"

#import "DCFineTuneSliderDemoViewController.h"

@implementation DCFineTuneSliderDemoAppDelegate

@synthesize window;
@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window.rootViewController = self.viewController;
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (void)dealloc
{
	[window release];
	[viewController release];
    [super dealloc];
}

@end
