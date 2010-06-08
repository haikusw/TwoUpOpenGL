//
//  Shader.vsh
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/6/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

attribute vec4 position;
attribute vec4 color;

varying vec4 colorVarying;

//uniform float translate;
uniform float t;
uniform float frequency;
uniform float xAmplitude;
uniform float yAmplitude;
uniform float phase;

const float _PI = 3.141592653;

void main()
{
    gl_Position = position;
    gl_Position.x += phase * xAmplitude * sin(2.0 * _PI * t * frequency);
    gl_Position.y += phase * yAmplitude * sin(2.0 * _PI * t * frequency);

    colorVarying = color;
}
