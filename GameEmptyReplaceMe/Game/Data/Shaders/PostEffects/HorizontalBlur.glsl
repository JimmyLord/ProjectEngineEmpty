#ifdef WIN32
#define lowp
#define mediump
#else
precision mediump float;
#endif

varying vec2 v_UVCoord;

#ifdef VertexShader

attribute vec4 a_Position;
attribute vec2 a_UVCoord;

uniform mat4 u_WorldViewProj;

void main()
{
    gl_Position = a_Position;
	v_UVCoord = a_UVCoord;
}

#endif

#ifdef FragmentShader

uniform sampler2D u_TextureColor;

void main()
{
	vec4 color = vec4(0); //texture2D( u_TextureColor, v_UVCoord );

    float offset = 2.0/1024.0;

	color += texture2D( u_TextureColor, vec2( v_UVCoord.x - offset*4.0, v_UVCoord.y ) ) * 0.05;
	color += texture2D( u_TextureColor, vec2( v_UVCoord.x - offset*3.0, v_UVCoord.y ) ) * 0.09;
	color += texture2D( u_TextureColor, vec2( v_UVCoord.x - offset*2.0, v_UVCoord.y ) ) * 0.13;
	color += texture2D( u_TextureColor, vec2( v_UVCoord.x - offset,     v_UVCoord.y ) ) * 0.15;
	color += texture2D( u_TextureColor, v_UVCoord                                     ) * 0.16;
	color += texture2D( u_TextureColor, vec2( v_UVCoord.x + offset,     v_UVCoord.y ) ) * 0.15;
	color += texture2D( u_TextureColor, vec2( v_UVCoord.x + offset*2.0, v_UVCoord.y ) ) * 0.13;
	color += texture2D( u_TextureColor, vec2( v_UVCoord.x + offset*3.0, v_UVCoord.y ) ) * 0.09;
	color += texture2D( u_TextureColor, vec2( v_UVCoord.x + offset*4.0, v_UVCoord.y ) ) * 0.05;

	gl_FragColor = color;
}

#endif
