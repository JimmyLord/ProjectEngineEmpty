BuildSingleProjectPremake = function(folder, filename)
    local rootDir = os.getcwd();
    os.chdir( folder )
    include( filename )
    os.chdir( rootDir )
end

workspace "EmptyReplaceMe"
    configurations  { "Debug", "Release", "EditorDebug", "EditorRelease" }
    startproject    "EmptyReplaceMe"

    filter "system:windows"
        platforms       { "x86", "x64" }

    vpaths { [""] = {
        "../notes.txt",
        "../todo.todo",
        "premake5.lua",
        "Game/EditorPrefs.ini",
        "Game/imgui.ini",
    } }

externalProject "MyFramework"
    location        "../Framework/MyFramework"
    uuid            "016089D0-2136-4A3D-B08C-5031542BE1D7"
    kind            "StaticLib"
    language        "C++"

BuildSingleProjectPremake( "../Engine/MyEngine/", "premake5inc.lua" )

externalProject "SharedGameCode"
    location        "../Engine/Libraries/SharedGameCode"
    uuid            "9E4D91C3-6ED5-4DFD-B6CD-ADA011C049B8"
    kind            "StaticLib"
    language        "C++"

group "Physics"
    externalProject "BulletCollision"
        location        "../Engine/Libraries"
        uuid            "1BD50A98-FB78-7F43-84A9-82901F5A00D0"
        kind            "StaticLib"
        language        "C++"

    externalProject "BulletDynamics"
        location        "../Engine/Libraries"
        uuid            "AD82F95E-C422-7443-A26D-57999762CED9"
        kind            "StaticLib"
        language        "C++"

    externalProject "LinearMath"
        location        "../Engine/Libraries"
        uuid            "5E81B361-BFF0-A443-A143-44C7B2164E8E"
        kind            "StaticLib"
        language        "C++"

    externalProject "Box2D"
        location        "../Framework/Libraries"
        uuid            "98400D17-43A5-1A40-95BE-C53AC78E7694"
        kind            "StaticLib"
        language        "C++"
group ""
project "EmptyReplaceMe"
    location        "Game"
    dependson       { "Box2D", "BulletCollision", "BulletDynamics", "LinearMath", "MyFramework", "MyEngine", "SharedGameCode" }
    kind            "WindowedApp"
    language        "C++"
    targetdir       "Output/%{cfg.platform}-%{prj.name}-%{cfg.buildcfg}"
    objdir          "Output/Intermediate/%{cfg.platform}-%{prj.name}-%{cfg.buildcfg}"
    pchheader       "GameCommonHeader.h"
    pchsource       "Game/SourceCommon/GameCommonHeader.cpp"

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
