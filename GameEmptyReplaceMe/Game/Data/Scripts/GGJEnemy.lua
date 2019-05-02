-- test script

GGJEnemy =
{

Externs =
{
	-- name, type, initial value
	{ "Speed", "Float", 10 },
};

OnLoad = function(this)
end,

OnPlay = function(this)
	math.randomseed( os.time() );
end,

OnStop = function(this)
end,

OnTouch = function(this, action, id, x, y, pressure, size)
	-- LogInfo( "OnTouch " .. id .. "\n" );
end,

OnButtons = function(this, action, id)
end,

Tick = function(this, deltaTime)
	
	local transform = this.gameobject:GetTransform();
	local pos = transform:GetLocalPosition();

	pos.z = pos.z + deltaTime * this.Speed;

	if( pos.z >= 20 ) then
		pos.z = pos.z - 160;
		r = math.random();
		pos.x = r * 6.28;
	end

	transform:SetLocalPosition( pos );

end,

}