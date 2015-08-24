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

void main()
{
    gl_FragColor = vec4( gl_FragCoord.x / 754, gl_FragCoord.y / 409, 0, 1 );
    //gl_FragColor = vec4( gl_FragCoord.x / 251, gl_FragCoord.y / 122, 0, 1 );
    //gl_FragColor = vec4( gl_FragCoord.x / 754, gl_FragCoord.y, 0, 1 );
}

#endif
