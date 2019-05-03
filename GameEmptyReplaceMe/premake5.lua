workspace "PremakeEmptyReplaceMe"
    configurations		{ "Debug", "Release", "EditorDebug", "EditorRelease" }

    -- These settings will be inherited by all projects defined below.
    filter "system:windows"
        platforms       { "x86", "x64" }
        defines         "MYFW_WINDOWS"
        systemversion   "latest"

    filter "configurations:Debug or EditorDebug"
        defines         "_DEBUG"
        symbols         "on"

    filter "configurations:Release or EditorRelease"
        defines         "NDEBUG"
        optimize        "Full"

    filter "configurations:EditorDebug or EditorRelease"
        defines         { "MYFW_EDITOR", "MYFW_USING_IMGUI" }

    filter "system:windows"
		characterset	"MBCS"

externalProject "MyFramework"
    location        "../Framework/MyFramework"
    uuid            "016089D0-2136-4A3D-B08C-5031542BE1D7"
    kind            "StaticLib"
    language        "C++"

externalProject "MyEngine"
    location        "../Engine/MyEngine"
    uuid            "CBF52F7E-23CE-4846-B48C-0146D0879805"
    kind            "StaticLib"
    language        "C++"

externalProject "SharedGameCode"
    location        "../Engine/Libraries/SharedGameCode"
    uuid            "9E4D91C3-6ED5-4DFD-B6CD-ADA011C049B8"
    kind            "StaticLib"
    language        "C++"

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

project "PremakeEmptyReplaceMe"
    location		"Game"
    dependson		{ "MyFramework", "MyEngine", "SharedGameCode" }
    kind			"WindowedApp"
    language		"C++"
    targetdir		"Output/%{cfg.platform}-%{prj.name}-%{cfg.buildcfg}"
    objdir			"Output/Intermediate/%{cfg.platform}-%{prj.name}-%{cfg.buildcfg}"
	pchheader		"GameCommonHeader.h"
	pchsource		"Game/SourceCommon/GameCommonHeader.cpp"

    includedirs {
		"Game/SourceCommon",
		"../Framework/Libraries/b2Settings",
		"../Framework/Libraries/Box2D",
	}

    files {
		"Game/SourceCommon/**.h",
		"Game/SourceCommon/**.cpp",
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
		files {
			"Game/SourceWindows/**.h",
			"Game/SourceWindows/**.cpp",
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

	filter "files:Game/SourceWindows/WinMainWx.*"
		flags "ExcludeFromBuild"
