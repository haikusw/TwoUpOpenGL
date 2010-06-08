//
//  TwoUpOpenGLAppDelegate.m
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/6/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import "TwoUpOpenGLAppDelegate.h"
#import "TwoUpOpenGLViewController.h"

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>

@implementation TwoUpOpenGLAppDelegate

@synthesize context = m_context;
@synthesize viewController = m_viewController;
@synthesize window = m_window;

- (void)dealloc {
	
	[EAGLContext setCurrentContext:nil];    
    [m_context release]; 	
	m_context = nil;

	[m_viewController release];
    m_viewController = nil;

    [m_window release];	m_window = nil;	self.window	= nil;
	
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	m_context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
	
	if (nil == m_context) {
		
		NSLog(@"Can't create context");
	}
	
	BOOL didIt = NO;
	didIt = [EAGLContext setCurrentContext:m_context];
	
	if (didIt == NO) {
		
		NSLog(@"Can't set current context");
	}
	
	self.viewController = [[TwoUpOpenGLViewController alloc] initWithNibName:@"TwoUpOpenGLViewController" 
																	 context:m_context];
	[self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];

//    [self.upperView startAnimation];
//    [self.lowerView startAnimation];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
//    [self.upperView startAnimation];
//    [self.lowerView startAnimation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [self.upperView startAnimation];
//    [self.lowerView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
//    [self.upperView startAnimation];
//    [self.lowerView startAnimation];
}

@end
