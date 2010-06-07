//
//  TwoUpOpenGLAppDelegate.m
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/6/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import "TwoUpOpenGLAppDelegate.h"
#import "EAGLView.h"

@implementation TwoUpOpenGLAppDelegate

@synthesize window = m_window;
@synthesize upperView = m_upperView;
@synthesize lowerView = m_lowerView;

- (void)dealloc {
	
    [m_window		release];	m_window	= nil;
    [m_upperView	release];	m_upperView	= nil;
    [m_lowerView	release];	m_lowerView	= nil;
	
    self.window = nil;
	
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
    [self.upperView startAnimation];
    [self.lowerView startAnimation];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.upperView startAnimation];
    [self.lowerView startAnimation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.upperView startAnimation];
    [self.lowerView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.upperView startAnimation];
    [self.lowerView startAnimation];
}

@end
