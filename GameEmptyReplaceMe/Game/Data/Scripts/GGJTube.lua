-- test script

GGJTube =
{

Externs =
{
	-- name, type, initial value
	{ "Speed", "Float", 1 },
};

OnLoad = function()
end,

OnPlay = function()
end,

OnStop = function()
end,

OnTouch = function(action, id, x, y, pressure, size)
	-- LogInfo( "OnTouch " .. id .. "\n" );
end,

OnButtons = function(action, id)
end,

Tick = function(deltaTime)
	
	local transform = this.gameobject:GetTransform();
	local pos = transform:GetLocalPosition();

	pos.z = pos.z + deltaTime * this.Speed;

	if( pos.z >= 10 ) then
		pos.z = pos.z - 60;
	end

	transform:SetLocalPosition( pos );

end,

}