//
//  EAGLView.m
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/6/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import "EAGLView.h"
#import "ES1Renderer.h"
#import "ES2Renderer.h"

@implementation EAGLView

@synthesize animating;
@dynamic animationFrameInterval;

// You must implement this method
+ (Class)layerClass {
    return [CAEAGLLayer class];
}

//The EAGL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder {    
    if ((self = [super initWithCoder:coder]))
    {
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;

        eaglLayer.opaque = TRUE;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:FALSE], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];

		if (self.tag == 22) {
			
			renderer = [[ES2Renderer alloc] initWithViewTag:self.tag 
												  frequency:0.200/4.0 
												 xAmplitude:0.45 
												 yAmplitude:0.001 
													  phase:1.0];
		} else {
			
			renderer = [[ES2Renderer alloc] initWithViewTag:self.tag 
												  frequency:0.200 
												 xAmplitude:0.001 
												 yAmplitude:0.25 
													  phase:-1.0];
		}

//		renderer = [[ES1Renderer alloc] init];

		if (!renderer) {
			[self release];
			return nil;
		}
		
        animating = FALSE;
        displayLinkSupported = FALSE;
		
        animationFrameInterval = 1;
        displayLink = nil;
        animationTimer = nil;

		
		
		
		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Don't Use for When There is More Then One EAGL View !!!!!!!!!!!!!!!!!!!!!!!!!!
		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Don't Use for When There is More Then One EAGL View !!!!!!!!!!!!!!!!!!!!!!!!!!
		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Don't Use for When There is More Then One EAGL View !!!!!!!!!!!!!!!!!!!!!!!!!!
//        NSString *reqSysVer = @"3.1";
//        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
//
//        if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending) {
//			displayLinkSupported = TRUE;
//		}
		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Don't Use for When There is More Then One EAGL View !!!!!!!!!!!!!!!!!!!!!!!!!!
		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Don't Use for When There is More Then One EAGL View !!!!!!!!!!!!!!!!!!!!!!!!!!
		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Don't Use for When There is More Then One EAGL View !!!!!!!!!!!!!!!!!!!!!!!!!!
		
		
		
		
		
    }

    return self;
}

- (void)drawView:(id)sender {
    [renderer render];
}

- (void)layoutSubviews {
    [renderer resizeFromLayer:(CAEAGLLayer*)self.layer];
    [self drawView:nil];
}

- (NSInteger)animationFrameInterval {
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval {
	
    // Frame interval defines how many display frames must pass between each time the
    // display link fires. The display link will only fire 30 times a second when the
    // frame internal is two on a display that refreshes 60 times a second. The default
    // frame interval setting of one will fire 60 times a second when the display refreshes
    // at 60 times a second. A frame interval setting of less than one results in undefined
    // behavior.
    if (frameInterval >= 1)
    {
        animationFrameInterval = frameInterval;

        if (animating)
        {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void)startAnimation {
    if (!animating)
    {
        if (displayLinkSupported)
        {
            // CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
            // if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
            // not be called in system versions earlier than 3.1.

            displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(drawView:)];
            [displayLink setFrameInterval:animationFrameInterval];
            [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        }
        else
            animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval) target:self selector:@selector(drawView:) userInfo:nil repeats:TRUE];

        animating = TRUE;
    }
}

- (void)stopAnimation {
    if (animating)
    {
        if (displayLinkSupported)
        {
            [displayLink invalidate];
            displayLink = nil;
        }
        else
        {
            [animationTimer invalidate];
            animationTimer = nil;
        }

        animating = FALSE;
    }
}

- (void)dealloc {
    [renderer release];

    [super dealloc];
}

@end
