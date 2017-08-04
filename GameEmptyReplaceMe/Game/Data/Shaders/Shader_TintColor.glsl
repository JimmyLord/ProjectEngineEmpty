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

#endif

#ifdef FragmentShader

exposed uniform vec4 u_FragmentColor;
exposed uniform vec4 u_Color2;

uniform vec3 u_WSCameraPos;
uniform float u_Shininess;

#define NUM_DIR_LIGHTS 1
#include <Include/Light_Uniforms.glsl>
#include <Include/Light_Functions.glsl>

void main()
{
    // Calculate the normal vector in world space. normalized again since interpolation can/will distort it.
    //   TODO: handle normal maps.
    vec3 WSnormal = normalize( v_WSNormal );

    // Hardcoded ambient
    vec3 finalambient = vec3( 0.2, 0.2, 0.2 );

    // Accumulate diffuse and specular color for all lights.
    vec3 finaldiffuse = vec3(0,0,0);
    vec3 finalspecular = vec3(0,0,0);

    DirLightContribution( v_WSPosition.xyz, u_WSCameraPos, WSnormal, u_Shininess, finaldiffuse, finalspecular );
    //finaldiffuse *= shadowperc;

    // Add in each light, one by one. // finaldiffuse, finalspecular are inout.
#if NUM_LIGHTS > 0
    for( int i=0; i<NUM_LIGHTS; i++ )
        PointLightContribution( u_LightPos[i], u_LightColor[i], u_LightAttenuation[i], v_WSPosition.xyz, u_WSCameraPos, WSnormal, u_Shininess, finaldiffuse, finalspecular );
#endif

    // Mix the texture color with the light color.
    vec3 ambdiff = u_FragmentColor.rgb * u_Color2.rgb * ( finalambient + finaldiffuse );
    vec3 spec = finalspecular;

    // Calculate final color
    gl_FragColor.rgb = ambdiff + spec;
    gl_FragColor.a = u_FragmentColor.a;
}

#endif
