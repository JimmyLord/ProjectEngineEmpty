//
// Copyright (c) 2014-2015 Jimmy Lord http://www.flatheadgames.com
//
// This software is provided 'as-is', without any express or implied warranty.  In no event will the authors be held liable for any damages arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

#ifndef __ComponentAIChasePlayer_H__
#define __ComponentAIChasePlayer_H__

class ComponentAIChasePlayer : public ComponentUpdateable
{
public:
    ComponentTransform* m_pComponentTransform;
    ComponentTransform* m_pPlayerComponentTransform;

public:
    ComponentAIChasePlayer(EngineCore* pEngineCore, ComponentSystemManager* pComponentSystemManager);
    virtual ~ComponentAIChasePlayer();

    virtual cJSON* ExportAsJSONObject(bool savesceneid, bool saveid);
    virtual void ImportFromJSONObject(cJSON* jsonobj, SceneID sceneid);

    virtual void Reset();
    virtual void CopyFromSameType_Dangerous(ComponentBase* pObject) { *this = (ComponentAIChasePlayer&)*pObject; }
    virtual ComponentAIChasePlayer& operator=(const ComponentAIChasePlayer& other);

    virtual void Tick(float deltaTime);

public:
#if MYFW_EDITOR
#if MYFW_USING_WX
    static bool m_PanelWatchBlockVisible;

    virtual void AddToObjectsPanel(wxTreeItemId gameobjectid);
    static void StaticOnLeftClick(void* pObjectPtr, wxTreeItemId id, unsigned int count) { ((ComponentAIChasePlayer*)pObjectPtr)->OnLeftClick( count, true ); }
    void OnLeftClick(unsigned int count, bool clear);
    virtual void FillPropertiesWindow(bool clear, bool addcomponentvariables = false, bool ignoreblockvisibleflag = false);
    static void StaticOnNewParentTransformDrop(void* pObjectPtr, int controlid, int x, int y) { ((ComponentAIChasePlayer*)pObjectPtr)->OnNewParentTransformDrop(controlid, x, y); }
    void OnNewParentTransformDrop(int controlid, int x, int y);
#endif //MYFW_USING_WX
#endif //MYFW_EDITOR
};

#endif //__ComponentAIChasePlayer_H__
