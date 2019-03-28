-- DemoLoadPauseMenu Script

DemoLoadPauseMenu =
{

OnLoad = function()
	EngineCore:RequestScene( "Data/Scenes/DemoPauseMenu.scene" );
end,

OnPlay = function()
end,

OnStop = function()
end,

OnTouch = function(action, id, x, y, pressure, size)
end,

OnButtons = function(action, id)
end,

Tick = function(deltaTime)
end

}
