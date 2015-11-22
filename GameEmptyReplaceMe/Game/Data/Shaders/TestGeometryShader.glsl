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
    // draw the original primitive
    for( int i=0; i<3; i++ )
    {
        gl_Position = u_WorldViewProj * gl_in[i].gl_Position;
        EmitVertex();
    }
    EndPrimitive();

    // draw a second primitive 6 units over in model space.
    for( int i=0; i<3; i++ )
    {
        vec4 mspos = gl_in[i].gl_Position;
        mspos.x += 6;
        gl_Position = u_WorldViewProj * mspos;
        EmitVertex();
    }
    EndPrimitive();

    // draw a third primitive.
    for( int i=0; i<3; i++ )
    {
        vec4 mspos = gl_in[i].gl_Position;
        mspos.y += 4;
        gl_Position = u_WorldViewProj * mspos;
        EmitVertex();
    }
    EndPrimitive();

    // draw a fourth primitive.
    for( int i=0; i<3; i++ )
    {
        vec4 mspos = gl_in[i].gl_Position;
        mspos.x += 6;
        mspos.y += 4;
        gl_Position = u_WorldViewProj * mspos;
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
