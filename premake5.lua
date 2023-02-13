local rootFolder = os.getcwd()
local buildFolder = os.getcwd() .. "/build/"
os.mkdir( buildFolder )

BuildSingleProjectPremake = function(folder, filename)
    os.chdir( folder )
    include( filename )
    os.chdir( rootFolder )
end

-- Premake configuration options
PremakeConfig_UseMemoryTracker = true
PremakeConfig_UseMono = false

-- Workspace
workspace "EmptyReplaceMe"
    configurations  { "Debug", "Release", "EditorDebug", "EditorRelease" }
    location        ( buildFolder )
    startproject    "EmptyReplaceMe"
    cppdialect      "C++17"

    filter "system:windows"
        platforms       { "x86", "x64" }

BuildSingleProjectPremake( "GameEmptyReplaceMe/", "premake5inc.lua" )
BuildSingleProjectPremake( "Engine/", "premake5inc.lua" )
BuildSingleProjectPremake( "Framework/", "premake5inc.lua" )
BuildSingleProjectPremake( "Engine/Libraries/SharedGameCode/", "premake5inc.lua" )

group "Physics"
    BuildSingleProjectPremake( "Engine/Libraries/", "premake5inc-bullet.lua" )
    BuildSingleProjectPremake( "Framework/Libraries/", "premake5inc-box2d.lua" )
group ""
