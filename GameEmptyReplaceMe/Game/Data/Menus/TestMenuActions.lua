-- test Enemy script, chases the player.

TestMenuActions =
{

OnPlay = function(this)
	--LogInfo( "OnPlay\n" );
end,

OnStop = function(this)
	--LogInfo( "OnStop\n" );
end,

OnTouch = function(this, action, id, x, y, pressure, size)
	--LogInfo( "OnTouch\n" );
end,

OnButtons = function(this, action, id)
	--LogInfo( "OnButtons\n" );
end,

Tick = function(this, deltaTime)
	--LogInfo( "Tick\n" );
end,

PressedMenuButton = function(this, deltaTime)
	LogInfo( "PressedMenuButton was called\n" );
end,

}