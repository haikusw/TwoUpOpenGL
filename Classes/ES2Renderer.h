//
//  ES2Renderer.h
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/6/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import "ESRenderer.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface ES2Renderer : NSObject <ESRenderer>
{
@private
    EAGLContext *context;

	NSUInteger m_viewTag;
	float m_frequency;
	float m_amplitude;
	float m_phase;
	
    // The pixel dimensions of the CAEAGLLayer
    GLint backingWidth;
    GLint backingHeight;

    // The OpenGL ES names for the framebuffer and renderbuffer used to render to this view
    GLuint defaultFramebuffer, colorRenderbuffer;

    GLuint program;
}

- (id)initWithViewTag:(NSUInteger)viewTag 
			frequency:(float)frequency 
			amplitude:(float)amplitude 
				phase:(float)phase;

- (void)render;
- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer;

@end

