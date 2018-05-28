#define EMISSIVE
#define USING_GEOMETRY_SHADER 1

#ifdef WIN32
#define lowp
#define mediump
#else
precision mediump float;
#endif

#ifdef VertexShader

attribute vec4 a_Position;

void main()
{
    gl_Position = a_Position;
}

#endif

#ifdef GeometryShader

layout(triangles) in;
layout(triangle_strip, max_vertices=12) out;

uniform mat4 u_WorldViewProj;

void main()
{
    // Draw the original primitive
    for( int i=0; i<3; i++ )
    {
        gl_Position = u_WorldViewProj * gl_in[i].gl_Position;
        EmitVertex();
    }
    EndPrimitive();

    // Draw a second primitive 6 units over in object space.
    for( int i=0; i<3; i++ )
    {
        vec4 objectSpacePos = gl_in[i].gl_Position;
        objectSpacePos.x += 6;
        gl_Position = u_WorldViewProj * objectSpacePos;
        EmitVertex();
    }
    EndPrimitive();

    // Draw a third primitive.
    for( int i=0; i<3; i++ )
    {
        vec4 objectSpacePos = gl_in[i].gl_Position;
        objectSpacePos.y += 4;
        gl_Position = u_WorldViewProj * objectSpacePos;
        EmitVertex();
    }
    EndPrimitive();

    // Draw a fourth primitive.
    for( int i=0; i<3; i++ )
    {
        vec4 objectSpacePos = gl_in[i].gl_Position;
        objectSpacePos.x += 6;
        objectSpacePos.y += 4;
        gl_Position = u_WorldViewProj * objectSpacePos;
        EmitVertex();
    }
    EndPrimitive();
}

#endif //GeometryShader

#ifdef FragmentShader

uniform sampler2D u_TextureColor;

void main()
{
	gl_FragColor = vec4( 1, 1, 1, 1 );
}

#endif
