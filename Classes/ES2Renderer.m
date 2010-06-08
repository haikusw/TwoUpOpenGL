//
//  ES2Renderer.m
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/6/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import "ES2Renderer.h"

// uniform index
enum {
    UNIFORM_TRANSLATE,
    UNIFORM_FREQUENCY,
    UNIFORM_X_AMPLITUDE,
    UNIFORM_Y_AMPLITUDE,
    UNIFORM_PHASE,
    NUM_UNIFORMS
};

GLint uniforms[NUM_UNIFORMS];

// attribute index
enum {
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
};

@interface ES2Renderer (PrivateMethods)
- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
@end

@implementation ES2Renderer

- (id)initWithViewTag:(NSUInteger)viewTag 
			frequency:(float)frequency 
		   xAmplitude:(float)xAmplitude 
		   yAmplitude:(float)yAmplitude 
				phase:(float)phase {
	
    if ((self = [super init])) {
		
		m_viewTag	= viewTag;
		m_frequency = frequency;
		m_xAmplitude = xAmplitude;
		m_yAmplitude = yAmplitude;
		m_phase		= phase;
		
        m_context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
		
        if (!m_context || ![EAGLContext setCurrentContext:m_context] || ![self loadShaders]) {
			
            [self release];
            return nil;
        }

		glGenFramebuffers(1, &m_framebuffer);
		glGenRenderbuffers(1, &m_colorbuffer);
		
        glBindFramebuffer(GL_FRAMEBUFFER, m_framebuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, m_colorbuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, m_colorbuffer);
    }
	
    return self;
}

- (void)render {

    static const GLfloat squareVertices[] = {
        -0.5f, -0.5f,
         0.5f, -0.5f,
        -0.5f,  0.5f,
         0.5f,  0.5f,
    };

	static GLubyte squareColors[16];
	

    // This application only creates a single context which is already set current at this point.
    // This call is redundant, but needed if dealing with multiple contexts.
    [EAGLContext setCurrentContext:m_context];

    // This application only creates a single default framebuffer which is already bound at this point.
    // This call is redundant, but needed if dealing with multiple framebuffers.
    glBindFramebuffer(GL_FRAMEBUFFER, m_framebuffer);
    glViewport(0, 0, m_width, m_height);

	if (m_viewTag == 22) {
		glClearColor(0.0f, 0.5, 1.0f, 1.0f);
	} else {
		glClearColor(1.0f, 0.0, 0.0f, 1.0f);
	}
		
    glClear(GL_COLOR_BUFFER_BIT);

    // Use shader program
    glUseProgram(m_program);

    // Update uniform value
    static float transY = 0.0f;
	glUniform1f(uniforms[UNIFORM_TRANSLATE], (GLfloat)transY);
	transY += 0.08f;	

	glUniform1f(uniforms[UNIFORM_FREQUENCY	], (GLfloat)m_frequency);
	glUniform1f(uniforms[UNIFORM_X_AMPLITUDE	], (GLfloat)m_xAmplitude);
	glUniform1f(uniforms[UNIFORM_Y_AMPLITUDE	], (GLfloat)m_yAmplitude);
	glUniform1f(uniforms[UNIFORM_PHASE		], (GLfloat)m_phase);

	if (m_viewTag == 22) {

		// vertex 0
		squareColors[0] = 255;
		squareColors[1] = 0;
		squareColors[2] = 0;
		squareColors[3] = 255;
		
		// vertex 1
		squareColors[4] = 255;
		squareColors[5] = 0;
		squareColors[6] = 0;
		squareColors[7] = 255;
		
		// vertex 2
		squareColors[8] = 255;
		squareColors[9] = 0;
		squareColors[10] = 0;
		squareColors[11] = 255;
		
		// vertex 3
		squareColors[12] = 255;
		squareColors[13] = 0;
		squareColors[14] = 0;
		squareColors[15] = 255;
				
	} else {

		// vertex 0
		squareColors[0] = 0;
		squareColors[1] = 128;
		squareColors[2] = 255;
		squareColors[3] = 255;
		
		// vertex 1
		squareColors[4] = 0;
		squareColors[5] = 128;
		squareColors[6] = 255;
		squareColors[7] = 255;
		
		// vertex 2
		squareColors[8] = 0;
		squareColors[9] = 128;
		squareColors[10] = 255;
		squareColors[11] = 255;
		
		// vertex 3
		squareColors[12] = 0;
		squareColors[13] = 128;
		squareColors[14] = 255;
		squareColors[15] = 255;
		
	}
	
    // Update attribute values
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, squareVertices);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, squareColors);
    glEnableVertexAttribArray(ATTRIB_COLOR);


    // Draw
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
    glBindRenderbuffer(GL_RENDERBUFFER, m_colorbuffer);
    [m_context presentRenderbuffer:GL_RENDERBUFFER];
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;

    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return FALSE;
    }

    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);

#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif

    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
    {
        glDeleteShader(*shader);
        return FALSE;
    }

    return TRUE;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;

    glLinkProgram(prog);

#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif

    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0)
        return FALSE;

    return TRUE;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;

    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }

    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0)
        return FALSE;

    return TRUE;
}

- (BOOL)loadShaders
{
    GLuint vertShader;
    GLuint fragShader;
	
    NSString *vertShaderPathname;
    NSString *fragShaderPathname;

    // Create shader program
    m_program = glCreateProgram();

    // Create and compile vertex shader
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
    {
        NSLog(@"Failed to compile vertex shader");
        return FALSE;
    }

    // Create and compile fragment shader
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])
    {
        NSLog(@"Failed to compile fragment shader");
        return FALSE;
    }

    // Attach vertex shader to program
    glAttachShader(m_program, vertShader);

    // Attach fragment shader to program
    glAttachShader(m_program, fragShader);

    // Bind attribute locations
    // this needs to be done prior to linking
    glBindAttribLocation(m_program, ATTRIB_VERTEX, "position");
    glBindAttribLocation(m_program, ATTRIB_COLOR, "color");

    // Link program
    if (![self linkProgram:m_program])
    {
        NSLog(@"Failed to link program: %d", m_program);

        if (vertShader)
        {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader)
        {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (m_program)
        {
            glDeleteProgram(m_program);
            m_program = 0;
        }
        
        return FALSE;
    }

    // Get uniform locations
    uniforms[UNIFORM_TRANSLATE]	= glGetUniformLocation(m_program, "t");
    uniforms[UNIFORM_FREQUENCY] = glGetUniformLocation(m_program, "frequency");
    uniforms[UNIFORM_X_AMPLITUDE] = glGetUniformLocation(m_program, "xAmplitude");
    uniforms[UNIFORM_Y_AMPLITUDE] = glGetUniformLocation(m_program, "yAmplitude");
    uniforms[UNIFORM_PHASE]		= glGetUniformLocation(m_program, "phase");

    // Release vertex and fragment shaders
    if (vertShader) glDeleteShader(vertShader);
    if (fragShader) glDeleteShader(fragShader);

    return TRUE;
}

- (BOOL)resizeFromLayer:(CAEAGLLayer *)layer
{
    // Allocate color buffer backing based on the current layer size
    glBindRenderbuffer(GL_RENDERBUFFER, m_colorbuffer);
    [m_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &m_width);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &m_height);

    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
    {
        NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
        return NO;
    }

    return YES;
}

- (void)dealloc
{
    // Tear down GL
    if (m_framebuffer)
    {
        glDeleteFramebuffers(1, &m_framebuffer);
        m_framebuffer = 0;
    }

    if (m_colorbuffer)
    {
        glDeleteRenderbuffers(1, &m_colorbuffer);
        m_colorbuffer = 0;
    }

    if (m_program)
    {
        glDeleteProgram(m_program);
        m_program = 0;
    }

    // Tear down context
    if ([EAGLContext currentContext] == m_context) {
		[EAGLContext setCurrentContext:nil];
	}

    [m_context release];
    m_context = nil;

    [super dealloc];
}

@end
