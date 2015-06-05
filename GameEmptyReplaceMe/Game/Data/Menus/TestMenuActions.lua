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

Tick = function(timepassed)
	--LogInfo( "Tick\n" );
end,

PressedMenuButton = function(timepassed)
	LogInfo( "PressedMenuButton was called\n" );
end,

}