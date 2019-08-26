-- This is not a complete premake5 lua script, it's meant to be included from another script that defines the workspace.
-- Like this, for example:
--     local rootDir = os.getcwd();
--     os.chdir( "../Engine/MyEngine/" )
--     include( "premake5inc.lua" )
--     os.chdir( rootDir )

project "EmptyReplaceMe"
    configurations      { "Debug", "Release", "EditorDebug", "EditorRelease" }
    dependson           { "Box2D", "BulletCollision", "BulletDynamics", "LinearMath", "MyFramework", "MyEngine", "SharedGameCode" }
    kind                "WindowedApp"
    language            "C++"
    targetdir           "$(SolutionDir)Output/%{cfg.platform}-%{prj.name}-%{cfg.buildcfg}"
    objdir              "$(SolutionDir)Output/Intermediate/%{cfg.platform}-%{prj.name}-%{cfg.buildcfg}"
    pchheader           "GameCommonHeader.h"
    pchsource           "Game/SourceCommon/GameCommonHeader.cpp"
    debugdir            "$(SolutionDir)../GameEmptyReplaceMe/Game"

    includedirs {
        "Game/SourceCommon",
        "$(SolutionDir)../Framework/Libraries/b2Settings",
        "$(SolutionDir)../Framework/Libraries/Box2D",
        "C:/Program Files (x86)/Mono/include/mono-2.0", -- TODO: Don't hardcode the path to mono installation.
    }

    files {
        "Game/SourceCommon/**.cpp",
        "Game/SourceCommon/**.h",
        "../notes.txt",
        "../todo.todo",
        "../premake5.lua",
        "../PremakeGenerateBuildFiles.bat",
        "../Windows-CreateSymLinksForData.bat",
        "premake5inc.lua",
        "Game/EditorPrefs.ini",
        "Game/imgui.ini",
        "Game/Data/**.glsl",
        "Game/Data/**.lua",
        "Game/Data/**.menu",
        "Game/Data/**.my2daniminfo",
        "Game/Data/**.mymaterial",
        "Game/Data/**.myprefabs",
        "Game/Data/**.mytemplate",
        "Game/Data/**.scene",
        "Game/DataSource/**.cs",
    }

    vpaths {
        -- Place these files in the root of the project.
        [""] = {
            "../notes.txt",
            "../todo.todo",
            "../premake5.lua",
            "../PremakeGenerateBuildFiles.bat",
            "../Windows-CreateSymLinksForData.bat",
            "premake5inc.lua",
            "Game/EditorPrefs.ini",
            "Game/imgui.ini",
        },
        -- Place the SourceCommon and SourceEditor folders in the root of the project.
        ["*"] = {
            "Game",
        },
    }

    links {
        "MyFramework",
        "MyEngine",
        "SharedGameCode",
        "Box2D",
        "BulletCollision",
        "BulletDynamics",
        "LinearMath",
    }

    filter "system:windows"
        defines         "MYFW_WINDOWS"
        systemversion   "latest"
        characterset    "MBCS"

        files {
            "Game/SourceWindows/**.cpp",
            "Game/SourceWindows/**.h",
        }

        libdirs {
            "../Framework/Libraries/pthreads-w32/lib/x86",
            "C:/Program Files (x86)/Mono/lib/", -- TODO: Don't hardcode the path to mono installation.
        }

        links {
            "pthreadVC2",
            "delayimp",
            "Ws2_32",
            "opengl32",
            "glu32",
            "xinput",
            "mono-2.0-sgen"
        }

        linkoptions { "/DELAYLOAD:pthreadVC2.dll" }

    filter { "system:windows", "files:Game/SourceWindows/WinMainWx.*" }
        flags           "ExcludeFromBuild"

    filter "configurations:Debug or EditorDebug"
        defines         "_DEBUG"
        symbols         "on"

    filter "configurations:Release or EditorRelease"
        defines         "NDEBUG"
        optimize        "Full"

    filter "configurations:EditorDebug or EditorRelease"
        defines         { "MYFW_EDITOR", "MYFW_USING_IMGUI" }
