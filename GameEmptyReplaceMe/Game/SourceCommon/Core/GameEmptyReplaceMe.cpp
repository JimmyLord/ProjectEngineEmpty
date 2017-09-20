//
// Copyright (c) 2012-2016 Jimmy Lord http://www.flatheadgames.com
//
// This software is provided 'as-is', without any express or implied warranty.  In no event will the authors be held liable for any damages arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

#include "GameCommonHeader.h"

char g_SceneToLoad[MAX_PATH];

#if MYFW_WINDOWS
#include "../../../Framework/MyFramework/SourceWindows/wglext.h"
#endif //MYFW_WINDOWS

GameEmptyReplaceMe::GameEmptyReplaceMe()
{
}

GameEmptyReplaceMe::~GameEmptyReplaceMe()
{
}

void GameEmptyReplaceMe::OneTimeInit()
{
    EngineCore::OneTimeInit();

    m_FreeAllMaterialsAndTexturesWhenUnloadingScene = true;

#if !MYFW_USING_WX
    if( g_SceneToLoad[0] != 0 )
    {
        RequestScene( g_SceneToLoad );
    }
    else
    {
#if MYFW_ANDROID
        RequestScene( "Data/Scenes/TestBasicScene.scene" );
#else
        RequestScene( "Data/Scenes/Initial.scene" );
        //RequestScene( "Data/Scenes/TestShadow.scene" );
        //RequestScene( "Data/Scenes/TestVoxels.scene" );
        //RequestScene( "Data/Scenes/TestPhysicsBox2D.scene" );
        //RequestScene( "Data/Scenes/TestPhysics.scene" );
#endif
    }
#endif

#if MYFW_WINDOWS
    // Turn on v-sync
    if( wglSwapInterval )
        wglSwapInterval( 1 );
#endif //MYFW_WINDOWS
}

void GameEmptyReplaceMe::OnSurfaceChanged(unsigned int startx, unsigned int starty, unsigned int width, unsigned int height)
{
    m_GameWidth = 640.0f;
    m_GameHeight = 960.0f;

    EngineCore::OnSurfaceChanged(startx, starty, width, height);

#if MYFW_USING_WX
    if( g_GLCanvasIDActive == 1 )
        return;
#endif
}

double GameEmptyReplaceMe::Tick(double TimePassed)
{
    return EngineCore::Tick( TimePassed );
}

void GameEmptyReplaceMe::OnDrawFrame(unsigned int canvasid)
{
    EngineCore::OnDrawFrame( canvasid );
}

bool GameEmptyReplaceMe::OnTouch(int action, int id, float x, float y, float pressure, float size)
{
    return EngineCore::OnTouch( action, id, x, y, pressure, size );
}

bool GameEmptyReplaceMe::OnButtons(GameCoreButtonActions action, GameCoreButtonIDs id)
{
    return EngineCore::OnButtons( action, id );
}

bool GameEmptyReplaceMe::OnKeys(GameCoreButtonActions action, int keycode, int unicodechar)
{
    return EngineCore::OnKeys( action, keycode, unicodechar );
}
