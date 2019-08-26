-- Menu Action File

DemoPauseMenuActions =
{

OnVisible = function(this, visible)
end,

OnAction = function(this, action)
	--LogInfo( "OnAction was called: " .. action .. "\n" );
	if( action == "ReloadScene" ) then
		EngineCore:ReloadScene( 1 );
	elseif( action == "LoadVoxels" ) then
		EngineCore:SwitchScene( "Data/Scenes/TestVoxels.scene" );
	end
end

}
