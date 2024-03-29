//
// Copyright (c) 2014-2016 Jimmy Lord http://www.flatheadgames.com
//
// This software is provided 'as-is', without any express or implied warranty.  In no event will the authors be held liable for any damages arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

#include "GameCommonHeader.h"

#if MYFW_USING_WX
bool ComponentAIChasePlayer::m_PanelWatchBlockVisible = true;
#endif

ComponentAIChasePlayer::ComponentAIChasePlayer(EngineCore* pEngineCore, ComponentSystemManager* pComponentSystemManager)
: ComponentUpdateable( pEngineCore, pComponentSystemManager )
{
    m_BaseType = BaseComponentType_Updateable;

    m_pComponentTransform = 0;
    m_pPlayerComponentTransform = 0;
}

ComponentAIChasePlayer::~ComponentAIChasePlayer()
{
}

#if MYFW_USING_WX
void ComponentAIChasePlayer::AddToObjectsPanel(wxTreeItemId gameobjectid)
{
    //wxTreeItemId id =
    g_pPanelObjectList->AddObject( this, ComponentAIChasePlayer::StaticOnLeftClick, ComponentBase::StaticOnRightClick, gameobjectid, "AIChasePlayer", ObjectListIcon_Component );
}

void ComponentAIChasePlayer::OnLeftClick(unsigned int count, bool clear)
{
    ComponentBase::OnLeftClick( count, clear );
}

void ComponentAIChasePlayer::FillPropertiesWindow(bool clear, bool addcomponentvariables, bool ignoreblockvisibleflag)
{
    m_ControlID_ComponentTitleLabel = g_pPanelWatch->AddSpace( "AI Chase Player", this, ComponentBase::StaticOnComponentTitleLabelClicked );

    if( m_PanelWatchBlockVisible || ignoreblockvisibleflag == true )
    {
        ComponentBase::FillPropertiesWindow( clear );

        const char* desc = "not following";
        if( m_pPlayerComponentTransform )
            desc = m_pPlayerComponentTransform->m_pGameObject->GetName();
        g_pPanelWatch->AddPointerWithDescription( "Object following", m_pPlayerComponentTransform, desc, this, ComponentAIChasePlayer::StaticOnNewParentTransformDrop );
    }
}

void ComponentAIChasePlayer::OnNewParentTransformDrop(int controlid, int x, int y)
{
    DragAndDropItem* pDropItem = g_DragAndDropStruct.GetItem( 0 );

    if( pDropItem->m_Type == DragAndDropType_ComponentPointer )
    {
        ComponentTransform* pComponent = (ComponentTransform*)pDropItem->m_Value;
        MyAssert( pComponent );

        if( pComponent->IsA( "TransformComponent" ) )
        {
            this->m_pPlayerComponentTransform = pComponent;
        }
    }
}
#endif //MYFW_USING_WX

cJSON* ComponentAIChasePlayer::ExportAsJSONObject(bool savesceneid, bool saveid)
{
    cJSON* component = ComponentUpdateable::ExportAsJSONObject( savesceneid, saveid );

    if( m_pPlayerComponentTransform )
        cJSON_AddNumberToObject( component, "ChasingGOID", m_pPlayerComponentTransform->GetGameObject()->GetID() );

    return component;
}

void ComponentAIChasePlayer::ImportFromJSONObject(cJSON* jsonobj, SceneID sceneid)
{
    ComponentUpdateable::ImportFromJSONObject( jsonobj, sceneid );

    unsigned int chasingid = 0;
    cJSONExt_GetUnsignedInt( jsonobj, "ChasingGOID", &chasingid );
    if( chasingid != 0 )
    {
        GameObject* pGameObject = g_pComponentSystemManager->FindGameObjectByID( sceneid, chasingid );
        MyAssert( pGameObject );

        if( pGameObject )
            m_pPlayerComponentTransform = pGameObject->GetTransform();
    }
}

void ComponentAIChasePlayer::Reset()
{
    ComponentUpdateable::Reset();

    m_pComponentTransform = m_pGameObject->GetTransform();

#if MYFW_USING_WX
    m_pPanelWatchBlockVisible = &m_PanelWatchBlockVisible;
#endif //MYFW_USING_WX
}

ComponentAIChasePlayer& ComponentAIChasePlayer::operator=(const ComponentAIChasePlayer& other)
{
    MyAssert( &other != this );

    ComponentUpdateable::operator=( other );

    this->m_pPlayerComponentTransform = other.m_pPlayerComponentTransform;

    return *this;
}

void ComponentAIChasePlayer::Tick(float deltaTime)
{
    if( m_pComponentTransform == 0 || m_pPlayerComponentTransform == 0 )
    {
        LOGInfo( LOGTag, "ComponentAIChasePlayer - transform or player's transform not set." );
        return;
    }

    Vector3 posdiff = m_pPlayerComponentTransform->GetWorldPosition() - m_pComponentTransform->GetWorldPosition();
    m_pComponentTransform->SetWorldPosition( m_pComponentTransform->GetWorldPosition() + posdiff * deltaTime );
}
