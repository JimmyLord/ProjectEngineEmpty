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

public class RandomMovement : MyScriptInterface
{
    private Random m_Random = new Random();
    private float m_TimeLeft = 0.5f;

    public float m_Speed = 2.0f;

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
        Log.Info( "Mono OnPlay" );
    }

    public override void OnStop()
    {
        Log.Info( "Mono OnStop" );
    }

    public override bool OnTouch(int action, int id, float x, float y, float pressure, float size)
    {
        //Log.Info( "Mono OnTouch" );
        return false;
    }

    public override bool OnButtons(int action, int id)
    {
        return false;
    }

    public override void Update(float deltaTime)
    {
        m_TimeLeft -= deltaTime;
        if( m_TimeLeft < 0.0f )
        {
            m_TimeLeft = 0.5f;

            int id = m_Random.Next( 1, 5 );
            if( id == 1 ) { m_KeyHeld_Left  = true; m_KeyHeld_Right = false; }
            if( id == 2 ) { m_KeyHeld_Right = true; m_KeyHeld_Left  = false; }
            if( id == 3 ) { m_KeyHeld_Up    = true; m_KeyHeld_Down  = false; }
            if( id == 4 ) { m_KeyHeld_Down  = true; m_KeyHeld_Up    = false; }
        }

        ComponentTransform transform = this.m_GameObject.GetTransform();
        vec3 pos = transform.GetLocalPosition();

        if( m_KeyHeld_Left )  pos.x -= m_Speed * deltaTime;
        if( m_KeyHeld_Right ) pos.x += m_Speed * deltaTime;
        if( m_KeyHeld_Up )    pos.z += m_Speed * deltaTime;
        if( m_KeyHeld_Down )  pos.z -= m_Speed * deltaTime;

        pos.x = Math.Clamp( pos.x, 2, 8 );
        pos.z = Math.Clamp( pos.z, 2, 8 );

        transform.SetLocalPosition( pos );
    }
}
