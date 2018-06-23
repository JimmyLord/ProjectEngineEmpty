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
uniform vec2 u_TextureColorTexelSize;

void main()
{
	vec3 color = vec3( 0 );

    vec2 offset = u_TextureColorTexelSize;

    vec2 uvs[9] = {
        v_UVCoord + vec2( -offset.x,  offset.y ), // top-left
        v_UVCoord + vec2(  0.0,       offset.y ), // top-center
        v_UVCoord + vec2(  offset.x,  offset.y ), // top-right
        v_UVCoord + vec2( -offset.x,  0.0 ),      // center-left
        v_UVCoord + vec2(  0.0,       0.0 ),      // center-center
        v_UVCoord + vec2(  offset.x,  0.0 ),      // center-right
        v_UVCoord + vec2( -offset.x, -offset.y ), // bottom-left
        v_UVCoord + vec2(  0.0,      -offset.y ), // bottom-center
        v_UVCoord + vec2(  offset.x, -offset.y )  // bottom-right 
    };

    //float kernel[9] = {
    //    -1, -1, -1,
    //    -1,  9, -1,
    //    -1, -1, -1
    //};
    float kernel[9] = {
         1,  1,  1,
         1, -8,  1,
         1,  1,  1
    };

    for( int i = 0; i < 9; i++ )
    {
        vec3 texcolor = texture2D( u_TextureColor, uvs[i] ).rgb;
        color += texcolor * kernel[i];
    }
    
    gl_FragColor = vec4( color, 1.0 );
}

#endif
