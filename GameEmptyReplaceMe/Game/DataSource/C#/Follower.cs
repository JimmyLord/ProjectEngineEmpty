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

public class Follower : MyScriptInterface
{
    public float m_Speed = 5.0f;
    public GameObject m_ObjectToFollow;

    public override void OnLoad()
    {
    }

    public override void OnPlay()
    {
    }

    public override void OnStop()
    {
    }

    public override bool OnTouch(int action, int id, float x, float y, float pressure, float size)
    {
        return false;
    }

    public override bool OnButtons(int action, int id)
    {
        return false;
    }

    public override void Update(float deltaTime)
    {
        if( m_ObjectToFollow == null )
        {
            Log.Info( "No object to follow." );
            return;
        }

        ComponentTransform transform = this.m_GameObject.GetTransform();

        vec3 pos = transform.GetLocalPosition();
        vec3 destination = m_ObjectToFollow.GetTransform().GetLocalPosition();
        
        vec3 dir = destination - pos;
        dir.Normalize();

        pos += dir * m_Speed * deltaTime;

        transform.SetLocalPosition( pos );
    }
}
