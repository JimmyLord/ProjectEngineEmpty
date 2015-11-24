#ifdef WIN32
#define lowp
#define mediump
#else
precision mediump float;
#endif

varying vec2 v_UVCoord;
varying vec4 v_Color;

#ifdef VertexShader

attribute vec3 a_Position;
attribute vec2 a_UVCoord;

attribute vec3 ai_Position;
attribute float ai_Scale;
attribute vec4 ai_Color;

uniform mat4 u_WorldViewProj;

void main()
{
	gl_Position = u_WorldViewProj * vec4( a_Position*ai_Scale + ai_Position, 1 );

	v_UVCoord = a_UVCoord;
	v_Color = vec4( ai_Color.rgb, 1 );
}

#endif

#ifdef FragmentShader

uniform sampler2D u_TextureColor;

void main()
{
	vec4 texcolor = texture2D( u_TextureColor, v_UVCoord ).rgbr;

	gl_FragColor = texcolor * v_Color;
}

#endif
