#ifndef WIN32
precision mediump float;
#endif

#ifdef VertexShader

attribute vec2 a_Position;

void main()
{
    gl_Position = vec4( a_Position, 0, 1 );
}

#endif

#ifdef FragmentShader

uniform vec2 u_FBSize;

void main()
{
    gl_FragColor = vec4( gl_FragCoord.x / u_FBSize.x, gl_FragCoord.y / u_FBSize.y, 0, 1 );
    //gl_FragColor = vec4( gl_FragCoord.x / 300, gl_FragCoord.y / 195, 0, 1 );
}

#endif
