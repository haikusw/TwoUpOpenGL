//
//  ES2Renderer.h
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/6/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface ES2Renderer : NSObject {
	
@private
    EAGLContext *m_context;

	NSUInteger m_viewTag;
	float m_frequency;
	float m_xAmplitude;
	float m_yAmplitude;
	float m_phase;
	
    GLint m_width;
    GLint m_height;

	GLuint m_framebuffer;
    GLuint m_colorbuffer;

    GLuint m_program;
}

- (id)initWithViewTag:(NSUInteger)viewTag 
			frequency:(float)frequency 
		   xAmplitude:(float)xAmplitude 
		   yAmplitude:(float)yAmplitude 
				phase:(float)phase;

- (void)render;
- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer;

@end

