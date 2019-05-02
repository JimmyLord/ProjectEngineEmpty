-- TestAudio Script

TestAudio =
{

OnLoad = function(this)
end,

OnPlay = function(this)
end,

OnStop = function(this)
end,

OnTouch = function(this, action, id, x, y, pressure, size)
	if( action == 0 ) then
        --this.gameobject:GetAudioPlayer():PlaySound( true );
        SoundManager:PlayCueByName( "Randomize" );
    end
end,

OnButtons = function(this, action, id)
end,

Tick = function(this, deltaTime)
end

}
