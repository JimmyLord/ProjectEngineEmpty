-- DemoLoadPauseMenu Script

DemoLoadPauseMenu =
{

OnLoad = function(this)
	EngineCore:RequestScene( "Data/Scenes/DemoPauseMenu.scene" );
end,

OnPlay = function(this)
end,

OnStop = function(this)
end,

OnTouch = function(this, action, id, x, y, pressure, size)
end,

OnButtons = function(this, action, id)
end,

Tick = function(this, deltaTime)
end

}
