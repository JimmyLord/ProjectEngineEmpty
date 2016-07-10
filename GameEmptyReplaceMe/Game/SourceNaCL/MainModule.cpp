//
// Copyright (c) 2015-2016 Jimmy Lord http://www.flatheadgames.com
//
// This software is provided 'as-is', without any express or implied warranty.  In no event will the authors be held liable for any damages arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

#include "GameCommonHeader.h"
#include "../../../Framework/MyFramework/SourceNaCL/MainInstance.h"
#include "ppapi/cpp/instance.h"
#include "ppapi/cpp/module.h"
#include "ppapi/gles2/gl2ext_ppapi.h"
#include "../SourceCommon/Core/GameEmptyReplaceMe.h"

// The Module class.  The browser calls the CreateInstance() method to create
// an instance of your NaCl module on the web page.  The browser creates a new
// instance for each <embed> tag with type="application/x-nacl".
class MainModule : public pp::Module
{
public:
    MainModule() : pp::Module()
    {
        g_pGameCore = MyNew GameEmptyReplaceMe();
    }

    virtual ~MainModule()
    {
        glTerminatePPAPI();
    }

    // Called by the browser when the module is first loaded and ready to run.
    // This is called once per module, not once per instance of the module on
    // the page.
    virtual bool Init()
    {
        return glInitializePPAPI( get_browser_interface() ) == GL_TRUE;
    }

    // Create and return a game instance object.
    // @param[in] instance The browser-side instance.
    // @return the plugin-side instance.
    virtual pp::Instance* CreateInstance(PP_Instance instance)
    {
        return MyNew MainInstance( instance );
    }
};

namespace pp
{
    // Factory function called by the browser when the module is first loaded.
    // The browser keeps a singleton of this module.  It calls the
    // CreateInstance() method on the object you return to make instances.  There
    // is one instance per <embed> tag on the page.  This is the main binding
    // point for your NaCl module with the browser.
    Module* CreateModule()
    {
        return MyNew MainModule();
    }
} // namespace pp
