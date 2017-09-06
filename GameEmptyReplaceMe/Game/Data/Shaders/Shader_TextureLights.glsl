#ifdef WIN32
//#version 120
#define lowp
#define mediump
#else
precision mediump float;
#endif

#ifdef PassMain

    #include <Include/WSVaryings.glsl>

    varying lowp vec2 v_UVCoord;
    varying lowp vec4 v_Color;
#if ReceiveShadows
    varying lowp vec4 v_ShadowPos;
#endif //ReceiveShadows

    uniform mat4 u_World;
    uniform mat4 u_WorldViewProj;

#if ReceiveShadows
    uniform mat4 u_ShadowLightWVPT;
    uniform sampler2D u_ShadowTexture;
#endif //ReceiveShadows

    uniform sampler2D u_TextureColor;
    uniform vec4 u_TextureTintColor;
    uniform vec4 u_TextureSpecColor;
    uniform float u_Shininess;

    uniform vec3 u_WSCameraPos;

    #define NUM_DIR_LIGHTS 1
    #include <Include/Light_Uniforms.glsl>

#ifdef VertexShader

    attribute vec4 a_Position;
    attribute vec2 a_UVCoord;
    attribute vec3 a_Normal;
    //attribute vec4 a_VertexColor;

    #include <Include/WSVaryings_Functions.glsl>

    void main()
    {
        gl_Position = u_WorldViewProj * a_Position;
#if ReceiveShadows
        v_ShadowPos = u_ShadowLightWVPT * a_Position;
#endif //ReceiveShadows

        SetWSPositionAndNormalVaryings( u_World, a_Position, a_Normal );
        v_UVCoord = a_UVCoord;
        v_Color = u_TextureTintColor;
    }

#endif //VertexShader

#ifdef FragmentShader

    #include <Include/Light_Functions.glsl>

    void main()
    {
        // Get the textures color.
        vec4 texcolor = texture2D( u_TextureColor, v_UVCoord );

        // Calculate the normal vector in local space. normalized again since interpolation can/will distort it.
        //   TODO: handle normal maps.
        vec3 WSnormal = normalize( v_WSNormal );

        // Whether fragment is in shadow or not, return 0.5 if it is, 1.0 if not.
        float shadowperc = CalculateShadowPercentage();

        // Hardcoded ambient
        vec3 finalambient = vec3( 0.2, 0.2, 0.2 );

        // Accumulate diffuse and specular color for all lights.
        vec3 finaldiffuse = vec3(0,0,0);
        vec3 finalspecular = vec3(0,0,0);
            
        DirLightContribution( v_WSPosition.xyz, u_WSCameraPos, WSnormal, u_Shininess, finaldiffuse, finalspecular );
        finaldiffuse *= shadowperc;

        // Add in each light, one by one. // finaldiffuse, finalspecular are inout.
#if NUM_LIGHTS > 0
        for( int i=0; i<NUM_LIGHTS; i++ )
            PointLightContribution( u_LightPos[i], u_LightColor[i], u_LightAttenuation[i], v_WSPosition.xyz, u_WSCameraPos, WSnormal, u_Shininess, finaldiffuse, finalspecular );
#endif

        // Mix the texture color with the light color.
        vec3 ambdiff = texcolor.rgb * v_Color.rgb * ( finalambient + finaldiffuse );
        vec3 spec = u_TextureSpecColor.rgb * finalspecular;

        // Calculate final color.
        gl_FragColor.rgb = ( ambdiff + spec );
        gl_FragColor.a = texcolor.a;
    }

#endif //Fragment Shader

#endif //PassMain

#ifdef PassShadowCastRGB

#ifdef VertexShader

    uniform mat4 u_WorldViewProj;

    attribute vec4 a_Position;

    void main()
    {
        gl_Position = u_WorldViewProj * a_Position;
    }

#endif //VertexShader

#ifdef FragmentShader

    void main()
    {
#if 1
        gl_FragColor = vec4(1,1,1,1);
#else
        float value = gl_FragCoord.z;

        // Pack depth float value into RGBA, for ES 2.0 where depth textures don't exist.
        const vec4 bitSh = vec4( 256.0*256.0*256.0, 256.0*256.0, 256.0, 1.0 );
        const vec4 bitMsk = vec4( 0.0, 1.0/256.0, 1.0/256.0, 1.0/256.0 );
        vec4 res = fract( value * bitSh );
        res -= res.xxyz * bitMsk;

        gl_FragColor = res;
#endif
    }

#endif //Fragment Shader

#endif //PassShadowCastRGB
