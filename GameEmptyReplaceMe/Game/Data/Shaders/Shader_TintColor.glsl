#define BLENDING On

#ifdef WIN32
#define lowp
#define mediump
#else
precision mediump float;
#endif

#undef ReceiveShadows
#define ReceiveShadows 0

#include <Include/WSVaryings.glsl>

#ifdef VertexShader

attribute vec4 a_Position;
attribute vec3 a_Normal;

uniform mat4 u_World;
uniform mat4 u_WorldViewProj;

#include <Include/Bone_AttribsAndUniforms.glsl>
#include <Include/Bone_Functions.glsl>
#include <Include/WSVaryings_Functions.glsl>

void main()
{
    vec4 pos;
    vec3 normal;
    
    ApplyBoneInfluencesToPositionAndNormalAttributes( a_Position, a_Normal, pos, normal );
    SetWSPositionAndNormalVaryings( u_World, pos, normal );

    gl_Position = u_WorldViewProj * pos;
}

#endif //VertexShader

#ifdef FragmentShader

//uniform sampler2D u_TestTexture;
uniform vec4 u_TextureTintColor;

uniform vec3 u_WSCameraPos;
uniform float u_Shininess;

#define NUM_DIR_LIGHTS 1
#include <Include/Light_Uniforms.glsl>
#include <Include/Light_Functions.glsl>

void main()
{
	vec4 materialColor = u_TextureTintColor;

#ifdef Deferred

	gl_FragData[0].rgb = materialColor.rgb;
	gl_FragData[0].a = u_Shininess;
	gl_FragData[1].xyz = v_WSPosition.xyz; //(v_WSPosition.xyz + vec3(15,0,0)) / 100.0;
	gl_FragData[1].a = 1;
	gl_FragData[2].xyz = normalize( v_WSNormal ); // / 2 + 0.5;
	gl_FragData[2].a = 1;

#else

    // Calculate the normal vector in world space. normalized again since interpolation can/will distort it.
    //   TODO: handle normal maps.
    vec3 WSnormal = normalize( v_WSNormal );

    // Accumulate ambient, diffuse and specular color for all lights.
    vec3 finalambient = vec3(0,0,0);
    vec3 finaldiffuse = vec3(0,0,0);
    vec3 finalspecular = vec3(0,0,0);

    DirLightContribution( v_WSPosition.xyz, u_WSCameraPos, WSnormal, u_Shininess, finalambient, finaldiffuse, finalspecular );
    //finaldiffuse *= shadowperc;

    // Add in each light, one by one. // finaldiffuse, finalspecular are inout.
#if NUM_LIGHTS > 0
    for( int i=0; i<NUM_LIGHTS; i++ )
        PointLightContribution( u_LightPos[i], u_LightColor[i], u_LightAttenuation[i], v_WSPosition.xyz, u_WSCameraPos, WSnormal, u_Shininess, finalambient, finaldiffuse, finalspecular );
#endif

    // Mix the texture color with the light color.
    vec3 ambdiff = materialColor.rgb * ( finalambient + finaldiffuse );
    //vec3 texcolor = texture2D( u_TestTexture, gl_FragCoord.xy/300.0 ).rgb;
    //vec3 ambdiff = texcolor * ( finalambient + finaldiffuse );
    vec3 spec = finalspecular;

    // Calculate final color
    gl_FragColor.rgb = ambdiff + spec;
    gl_FragColor.a = materialColor.a;

#endif //Deferred
}

#endif //FragmentShader
