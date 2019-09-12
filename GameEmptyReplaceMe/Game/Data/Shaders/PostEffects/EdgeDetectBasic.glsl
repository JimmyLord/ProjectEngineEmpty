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

// From http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl.
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4( 0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0 );
    //vec4 p = mix( vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g) );
    //vec4 q = mix( vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r) );
    vec4 p = c.g < c.b ? vec4( c.bg, K.wz ) : vec4( c.gb, K.xy );
    vec4 q = c.r < p.x ? vec4( p.xyw, c.r ) : vec4( c.r, p.yzx );

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x );
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
    vec3 p = abs( fract(c.xxx + K.xyz) * 6.0 - K.www );
    return c.z * mix( K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y );
}

void main()
{
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

#if 0
    // Apply kernel to each of the 3 color channels.
    {
    	vec3 color = vec3( 0 );
    
        for( int i = 0; i < 9; i++ )
        {
            vec3 texcolor = texture2D( u_TextureColor, uvs[i] ).rgb;
            color += texcolor * kernel[i];
        }
    
        gl_FragColor = vec4( color, 1.0 );
    }
#else
    // Apply kernel to the intensity of the HSV color values.
    {
        float intensity = 0.0f;

        for( int i = 0; i < 9; i++ )
        {
            vec3 texcolor = texture2D( u_TextureColor, uvs[i] ).rgb;
            vec3 hsv = rgb2hsv( texcolor );
            intensity += hsv.z * kernel[i];

            clamp( intensity, 0.0, 1.0 );
        }

#if 1
        vec3 texcolor = texture2D( u_TextureColor, uvs[4] ).rgb;
        vec3 hsv = rgb2hsv( texcolor );
        hsv.z = intensity;
        vec3 color = hsv2rgb( hsv );
        gl_FragColor = vec4( color, 1.0 );
#else
        gl_FragColor = vec4( intensity, intensity, intensity, 1.0 );
#endif
    }
#endif
}

#endif
