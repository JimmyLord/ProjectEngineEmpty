//
// Copyright (c) 2014-2015 Jimmy Lord http://www.flatheadgames.com
//
// This software is provided 'as-is', without any express or implied warranty.  In no event will the authors be held liable for any damages arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

#include "GameCommonHeader.h"

// sort by category, otherwise right-click menu will have duplicates.
// name(2nd column) is saved into the scene files, changing it will break objects.
ComponentTypeInfo g_GameComponentTypeInfo[Component_NumGameComponentTypes] = // ADDING_NEW_ComponentTypeGame
{
    { "Input handlers", "Track Mouse",      },
    { "AI",             "AI Chase Player",  },
};

ComponentBase* GameComponentTypeManager::CreateComponent(int type)
{
    ComponentBase* pComponent = 0;
    EngineCore* pEngineCore = m_pComponentSystemManager->GetEngineCore();
    
    if( type < Component_NumEngineComponentTypes )
        return EngineComponentTypeManager::CreateComponent( type );

    MyAssert( type != -1 );

    switch( type ) // ADDING_NEW_ComponentTypeGame
    {
    case ComponentType_InputTrackMousePos:  pComponent = MyNew ComponentInputTrackMousePos( pEngineCore, m_pComponentSystemManager ); break;
    case ComponentType_AIChasePlayer:       pComponent = MyNew ComponentAIChasePlayer(      pEngineCore, m_pComponentSystemManager ); break;
    }

    MyAssert( pComponent != 0 );

    pComponent->SetType( type );
    return pComponent;
}

unsigned int GameComponentTypeManager::GetNumberOfComponentTypes()
{
    return Component_NumComponentTypes;
}

const char* GameComponentTypeManager::GetTypeCategory(int type)
{
    if( type < Component_NumEngineComponentTypes )
        return EngineComponentTypeManager::GetTypeCategory( type );

    return g_GameComponentTypeInfo[type - Component_NumEngineComponentTypes].category;
}

const char* GameComponentTypeManager::GetTypeName(int type)
{
    if( type < Component_NumEngineComponentTypes )
        return EngineComponentTypeManager::GetTypeName( type );

    return g_GameComponentTypeInfo[type - Component_NumEngineComponentTypes].name;
}

int GameComponentTypeManager::GetTypeByName(const char* name)
{
    int type = EngineComponentTypeManager::GetTypeByName( name );
    if( type != -1 )
        return type;

    for( int i=0; i<Component_NumGameComponentTypes; i++ )
    {
        if( strcmp( g_GameComponentTypeInfo[i].name, name ) == 0 )
            return Component_NumEngineComponentTypes + i;
    }

    return -1;
}
