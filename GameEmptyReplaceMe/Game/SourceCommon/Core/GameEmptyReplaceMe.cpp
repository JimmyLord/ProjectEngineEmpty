//
// Copyright (c) 2012-2015 Jimmy Lord http://www.flatheadgames.com
//
// This software is provided 'as-is', without any express or implied warranty.  In no event will the authors be held liable for any damages arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

#include "GameCommonHeader.h"
#include "../../Framework/MyFramework/SourceWindows/wglext.h"

bool WGLExtensionSupported(const char *extension_name)
{
    // this is pointer to function which returns pointer to string with list of all wgl extensions
    PFNWGLGETEXTENSIONSSTRINGEXTPROC _wglGetExtensionsStringEXT = NULL;

    // determine pointer to wglGetExtensionsStringEXT function
    _wglGetExtensionsStringEXT = (PFNWGLGETEXTENSIONSSTRINGEXTPROC)wglGetProcAddress( "wglGetExtensionsStringEXT" );

    if( strstr( _wglGetExtensionsStringEXT(), extension_name ) == NULL )
    {
        // string was not found
        return false;
    }

    // extension is supported
    return true;
}

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
    extern char g_SceneToLoad[MAX_PATH];

    //m_pSceneFileToLoad = RequestFile( "Data/Scenes/test.scene" );
    if( g_SceneToLoad[0] != 0 )
        m_pSceneFileToLoad = RequestFile( g_SceneToLoad );
    else
        m_pSceneFileToLoad = RequestFile( "Data/Scenes/TestAnimation.scene" );
    m_SceneLoaded = false;
#endif

#if MYFW_WINDOWS
    // hacked in v-sync, TODO: clean this up
    PFNWGLSWAPINTERVALEXTPROC wglSwapIntervalEXT = 0;
    PFNWGLGETSWAPINTERVALEXTPROC wglGetSwapIntervalEXT = 0;

    if( WGLExtensionSupported( "WGL_EXT_swap_control" ) )
    {
        // Extension is supported, init pointers.
        wglSwapIntervalEXT = (PFNWGLSWAPINTERVALEXTPROC)wglGetProcAddress( "wglSwapIntervalEXT" );

        // this is another function from WGL_EXT_swap_control extension
        wglGetSwapIntervalEXT = (PFNWGLGETSWAPINTERVALEXTPROC)wglGetProcAddress( "wglGetSwapIntervalEXT" );
    }

    if( wglSwapIntervalEXT )
        wglSwapIntervalEXT( 1 );
#endif
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
