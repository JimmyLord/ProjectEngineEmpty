#define EMISSIVE

#ifdef WIN32
#define lowp
#define mediump
#else
precision mediump float;
#endif

#undef ReceiveShadows
#define ReceiveShadows 0

#ifdef VertexShader

attribute vec4 a_Position;
attribute vec3 a_Normal;

uniform mat4 u_WorldViewProj;

#include <Include/Bone_AttribsAndUniforms.glsl>
#include <Include/Bone_Functions.glsl>

void main()
{
    vec4 pos;
    vec3 normal;
    
    ApplyBoneInfluencesToPositionAndNormalAttributes( a_Position, a_Normal, pos, normal );

    gl_Position = u_WorldViewProj * pos;
}

#endif //VertexShader

#ifdef FragmentShader

uniform vec4 u_TextureTintColor;

void main()
{
	vec4 materialColor = u_TextureTintColor;

    // Calculate final color
    gl_FragColor = materialColor;
}

#endif //FragmentShader
