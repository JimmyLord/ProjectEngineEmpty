local rootFolder = os.getcwd()
local buildFolder = os.getcwd() .. "/build/"
os.mkdir( buildFolder )

BuildSingleProjectPremake = function(folder, filename)
    os.chdir( folder )
    include( filename )
    os.chdir( rootFolder )
end

workspace "EmptyReplaceMe"
    configurations  { "Debug", "Release", "EditorDebug", "EditorRelease" }
    location        ( buildFolder )
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

BuildSingleProjectPremake( "GameEmptyReplaceMe/", "premake5inc.lua" )
BuildSingleProjectPremake( "Engine/MyEngine/", "premake5inc.lua" )

externalProject "MyFramework"
    location        "Framework/MyFramework"
    uuid            "016089D0-2136-4A3D-B08C-5031542BE1D7"
    kind            "StaticLib"
    language        "C++"

externalProject "SharedGameCode"
    location        "Engine/Libraries/SharedGameCode"
    uuid            "9E4D91C3-6ED5-4DFD-B6CD-ADA011C049B8"
    kind            "StaticLib"
    language        "C++"

group "Physics"
    externalProject "BulletCollision"
        location        "Engine/Libraries"
        uuid            "1BD50A98-FB78-7F43-84A9-82901F5A00D0"
        kind            "StaticLib"
        language        "C++"

    externalProject "BulletDynamics"
        location        "Engine/Libraries"
        uuid            "AD82F95E-C422-7443-A26D-57999762CED9"
        kind            "StaticLib"
        language        "C++"

    externalProject "LinearMath"
        location        "Engine/Libraries"
        uuid            "5E81B361-BFF0-A443-A143-44C7B2164E8E"
        kind            "StaticLib"
        language        "C++"

    externalProject "Box2D"
        location        "Framework/Libraries"
        uuid            "98400D17-43A5-1A40-95BE-C53AC78E7694"
        kind            "StaticLib"
        language        "C++"
group ""
