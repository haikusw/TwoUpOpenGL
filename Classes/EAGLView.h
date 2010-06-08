//
//  EAGLView.h
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/6/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ES2Renderer.h"

@interface EAGLView : UIView {
	
@private
	ES2Renderer *m_render;

    BOOL animating;
    BOOL displayLinkSupported;
    NSInteger animationFrameInterval;
    // Use of the CADisplayLink class is the preferred method for controlling your animation timing.
    // CADisplayLink will link to the main display and fire every vsync when added to a given run-loop.
    // The NSTimer class is used only as fallback when running on a pre 3.1 device where CADisplayLink
    // isn't available.
    id displayLink;
    NSTimer *animationTimer;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void)initialize:(EAGLContext*)context;
- (void)startAnimation;
- (void)stopAnimation;
- (void)drawView:(id)sender;

@end
