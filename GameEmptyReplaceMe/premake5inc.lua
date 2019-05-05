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
    }

    files {
        "Game/SourceCommon/**.cpp",
        "Game/SourceCommon/**.h",
        "../notes.txt",
        "../todo.todo",
        "premake5.lua",
        "Game/EditorPrefs.ini",
        "Game/imgui.ini",
    }

    -- Place these files in the root of the project for easy access.
    vpaths { [""] = {
        "../notes.txt",
        "../todo.todo",
        "premake5.lua",
        "Game/EditorPrefs.ini",
        "Game/imgui.ini",
    } }

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
        }

        links {
            "pthreadVC2",
            "delayimp",
            "Ws2_32",
            "opengl32",
            "glu32",
            "xinput",
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

    filter {}
