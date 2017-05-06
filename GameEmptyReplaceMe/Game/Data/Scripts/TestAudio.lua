-- TestAudio Script

TestAudio =
{

OnLoad = function()
end,

OnPlay = function()
end,

OnStop = function()
end,

OnTouch = function(action, id, x, y, pressure, size)
	if( action == 0 ) then
        this.gameobject:GetAudioPlayer():PlaySound( true );
    end
end,

OnButtons = function(action, id)
end,

Tick = function(timepassed)
end

}
