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
    vec4 p = c.g < c.b ? vec4( c.bg, K.wz ) : vec4( c.gb, K.xy );
    vec4 q = c.r < p.x ? vec4( p.xyw, c.r ) : vec4( c.r, p.yzx );

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x );
}

float rgb2v(vec3 c)
{
    vec4 K = vec4( 0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0 );
    vec4 p = c.g < c.b ? vec4( c.bg, K.wz ) : vec4( c.gb, K.xy );
    vec4 q = c.r < p.x ? vec4( p.xyw, c.r ) : vec4( c.r, p.yzx );

    return q.x;
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

    float kernelX[9] = {
         1,  0, -1,
         2,  0, -2,
         1,  0, -1
    };

    float kernelY[9] = {
         1,  2,  1,
         0,  0,  0,
        -1, -2, -1
    };

#if 1
    {
        float Gx = 0.0;
        float Gy = 0.0;
        for( int i = 0; i < 9; i++ )
        {
            vec3 texcolor = texture2D( u_TextureColor, uvs[i] ).rgb;
            float gray = dot( texcolor.rgb, vec3(0.299, 0.587, 0.114) );
            Gx += gray * kernelX[i];
            Gy += gray * kernelY[i];
        }

        vec3 color = vec3( sqrt( Gx * Gx + Gy * Gy ) );

        gl_FragColor = vec4( color, 1.0 );
    }
#else
    {
        float Gx = 0.0;
        float Gy = 0.0;
        for( int i = 0; i < 9; i++ )
        {
            vec3 texcolor = texture2D( u_TextureColor, uvs[i] ).rgb;
            float gray = rgb2v( texcolor );
            Gx += gray * kernelX[i];
            Gy += gray * kernelY[i];
        }

        vec3 color = vec3( sqrt( Gx * Gx + Gy * Gy ) );

        gl_FragColor = vec4( color, 1.0 );
    }
#endif


    //float direction = atan( Gy, Gx );
    
    //vec3 Gx = vec3( 0.0 );
    //vec3 Gy = vec3( 0.0 );
    //for( int i = 0; i < 9; i++ )
    //{
    //    vec3 texcolor = texture2D( u_TextureColor, uvs[i] ).rgb;
    //    Gx += texcolor * kernelX[i];
    //    Gy += texcolor * kernelY[i];
    //}

    //vec3 color = sqrt( Gx * Gx + Gy * Gy );
    //
    //gl_FragColor = vec4( color, 1.0 );
}

#endif
