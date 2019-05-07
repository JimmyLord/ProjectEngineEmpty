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

BuildSingleProjectPremake( "GameEmptyReplaceMe/", "premake5inc.lua" )
BuildSingleProjectPremake( "Engine/", "premake5inc.lua" )
BuildSingleProjectPremake( "Framework/", "premake5inc.lua" )
BuildSingleProjectPremake( "Engine/Libraries/SharedGameCode/", "premake5inc.lua" )

group "Physics"
    BuildSingleProjectPremake( "Engine/Libraries/", "premake5inc-bullet.lua" )
    BuildSingleProjectPremake( "Framework/Libraries/", "premake5inc-box2d.lua" )
group ""
