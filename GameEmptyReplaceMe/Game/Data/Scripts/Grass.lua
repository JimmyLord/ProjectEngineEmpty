-- Grass Script

Grass =
{

Externs =
{
	-- name, type, initial value
	{ "ObjectsToTrack", "GameObject", "AnimGuy" },
};

OnLoad = function()
end,

OnPlay = function()
    this.deformTimer = 0;
    this.numpoints = 0;
    this.points =
    {
        Vector4(0,0,0,0), Vector4(0,0,0,0), Vector4(0,0,0,0), Vector4(0,0,0,0), Vector4(0,0,0,0),
    };
end,

OnStop = function()
end,

OnTouch = function(action, id, x, y, pressure, size)
end,

OnButtons = function(action, id)
end,

Tick = function(timepassed)
	local pos3 = this.ObjectsToTrack:GetTransform():GetLocalPosition();
    local pos4 = Vector4( pos3.x, pos3.y, pos3.z, 1 );

    local MAX_DEFORMS = 5.0;
    local deformUpdateFreq = 1/30.0;

    this.numpoints = MAX_DEFORMS;

    this.deformTimer = this.deformTimer - timepassed;
    if this.deformTimer < 0
    then
        this.deformTimer = deformUpdateFreq;
        for i = MAX_DEFORMS, 2, -1
        do
            this.points[i] = this.points[i-1]
            this.points[i].w = 1;--(MAX_DEFORMS-i)/MAX_DEFORMS;
        end
    end

    this.points[1] = pos4;
    --LogInfo( "Tick \n" );
end,

SetupCustomUniforms = function(programhandle)
    --LogInfo( "SetupCustomUniforms \n" );

    local loc = glGetUniformLocation( programhandle, "u_DeformXYZRadius" );
    glUniform4fv( loc, this.numpoints, this.points );
end

}
