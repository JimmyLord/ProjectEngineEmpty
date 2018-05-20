-- test Enemy script, chases the player.

TestMenuActions =
{

OnPlay = function()
	--LogInfo( "OnPlay\n" );
end,

OnStop = function()
	--LogInfo( "OnStop\n" );
end,

OnTouch = function(action, id, x, y, pressure, size)
	--LogInfo( "OnTouch\n" );
end,

OnButtons = function(action, id)
	--LogInfo( "OnButtons\n" );
end,

Tick = function(deltaTime)
	--LogInfo( "Tick\n" );
end,

PressedMenuButton = function(deltaTime)
	LogInfo( "PressedMenuButton was called\n" );
end,

}