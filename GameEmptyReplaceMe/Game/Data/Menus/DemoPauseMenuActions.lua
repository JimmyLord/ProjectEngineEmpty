-- Menu Action File

DemoPauseMenuActions =
{

OnVisible = function(visible)
end,

OnAction = function(action)
	--LogInfo( "OnAction was called: " .. action .. "\n" );
	if( action == "ReloadScene" ) then
		g_pEngineCore:ReloadScene( 1 );
	end
end

}
