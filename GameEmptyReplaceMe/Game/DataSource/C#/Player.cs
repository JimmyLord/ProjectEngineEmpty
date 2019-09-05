//
// Copyright (c) 2019 Jimmy Lord http://www.flatheadgames.com
//
// This software is provided 'as-is', without any express or implied warranty.  In no event will the authors be held liable for any damages arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

using System;
using MyEngine;

public class Player : MyScriptInterface
{
    public float m_Speed = 5.0f;

    private bool m_KeyHeld_Up = false;
    private bool m_KeyHeld_Down = false;
    private bool m_KeyHeld_Left = false;
    private bool m_KeyHeld_Right = false;

    public override void OnLoad()
    {
        Log.Info( "Mono OnLoad" );
    }

    public override void OnPlay()
    {
        //Log.Info( "Mono OnPlay" );
    }

    public override void OnStop()
    {
        //Log.Info( "Mono OnStop" );
    }

    public override bool OnTouch(int action, int id, float x, float y, float pressure, float size)
    {
        //Log.Info( "Mono OnTouch" );
        return false;
    }

    public override bool OnButtons(int action, int id)
    {
        if( action == 0 )
        {
            if( id == 1 ) m_KeyHeld_Left  = true; //Log.Info( "Mono OnButtons: A was Pressed" );
            if( id == 2 ) m_KeyHeld_Right = true; //Log.Info( "Mono OnButtons: D was Pressed" );
            if( id == 3 ) m_KeyHeld_Up    = true; //Log.Info( "Mono OnButtons: W was Pressed" );
            if( id == 4 ) m_KeyHeld_Down  = true; //Log.Info( "Mono OnButtons: S was Pressed" );

            if( id == 1 )
            {
                //vec3 values = new vec3( 10, 10, 0 );
                //Log.Info( "Values before: " + values.x + " " + values.y + " "+ values.z );
                //values.Normalize();
                ////System.Runtime.InteropServices.GCHandle handle = System.Runtime.InteropServices.GCHandle.Alloc( values, System.Runtime.InteropServices.GCHandleType.Pinned  );
                ////IntPtr ptr = System.Runtime.InteropServices.GCHandle.ToIntPtr( handle );
                ////vec3.Randomize( ptr );
                ////handle.Free();
                //Log.Info( "Values after : " + values.x + " " + values.y + " "+ values.z );
            }
            if( id == 2 )
            {
                //mat4 matrix = new mat4();
                //matrix.SetIdentity();
                //matrix.CreateSRT( new vec3(1,1,1), new vec3(0,0,0), new vec3(5,2,5) );
                //ComponentTransform transform = this.m_GameObject.GetTransform();
                //transform.SetLocalTransform( matrix );
            }
            if( id == 3 )
            {
                //GameObject test = ComponentSystemManager.CreateGameObject( "Test", false, true );
                //ComponentMeshPrimitive component = (ComponentMeshPrimitive)test.AddNewComponent( "Mesh-Primitive" );
                //component.SetPrimitiveType( ComponentMeshPrimitive.PrimitiveType.Icosphere );

                //MyMaterial mat = MaterialManager.GetFirstMaterial();
                ////Log.Info( mat.GetName() );
                //component.SetMaterial( mat, 0 );

                //ComponentTransform transform = (ComponentTransform)test.GetFirstComponentOfType( "TransformComponent" );
                //transform.SetLocalPosition( new vec3(5,2,7) );
            }
            if( id == 4 )
            {
                //EngineCore.RequestScene( "Data/Scenes/DemoPauseMenu.scene" );
            }
        }
        if( action == 1 )
        {
            if( id == 1 ) m_KeyHeld_Left  = false; //Log.Info( "Mono OnButtons: A was Released" );
            if( id == 2 ) m_KeyHeld_Right = false; //Log.Info( "Mono OnButtons: D was Released" );
            if( id == 3 ) m_KeyHeld_Up    = false; //Log.Info( "Mono OnButtons: W was Released" );
            if( id == 4 ) m_KeyHeld_Down  = false; //Log.Info( "Mono OnButtons: S was Released" );
        }
        if( action == 2 )
        {
            //if( id == 1 ) Log.Info( "Mono OnButtons: A is held" );
            //if( id == 2 ) Log.Info( "Mono OnButtons: D is held" );
            //if( id == 3 ) Log.Info( "Mono OnButtons: W is held" );
            //if( id == 4 ) Log.Info( "Mono OnButtons: S is held" );
        }

        return false;
    }

    public override void Update(float deltaTime)
    {
        //Log.Info( "Mono Update" );

        //ComponentTransform transform = this.m_GameObject.GetTransform();
        ComponentTransform transform = (ComponentTransform)this.m_GameObject.GetFirstComponentOfType( "TransformComponent" );
        if( transform != null )
        {
            vec3 pos = transform.GetLocalPosition();

            if( m_KeyHeld_Left )  pos.x -= m_Speed * deltaTime;
            if( m_KeyHeld_Right ) pos.x += m_Speed * deltaTime;
            if( m_KeyHeld_Up )    pos.z += m_Speed * deltaTime;
            if( m_KeyHeld_Down )  pos.z -= m_Speed * deltaTime;

            transform.SetLocalPosition( pos );

            //Log.Info( "New position: " + pos );
        }
    }
}
