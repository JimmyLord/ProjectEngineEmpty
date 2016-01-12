-- test script

CharacterController_2DPhysics =
{

Externs =
{
	-- name, type, initial value
	{ "Speed", "Float", 10 },
};

OnLoad = function()
end,

OnPlay = function()
	-- initialize some local variables
	this.dir = Vector2(0,0);
	this.jump = false;
end,

OnStop = function()
end,

OnTouch = function(action, id, x, y, pressure, size)
	-- LogInfo( "OnTouch " .. id .. "\n" );
end,

OnButtons = function(action, id)
	--LogInfo( "OnButtons " .. id .. "\n" );

	if( action == 2 ) then -- button held
		if( id == 1 ) then -- left
			this.dir.x = -1;
		end
		if( id == 2 ) then -- right
			this.dir.x = 1;
		end
	end

	if( action == 1 ) then -- button pressed
		if( id == 3 ) then -- up
			this.jump = true;
		end
		if( id == 4 ) then -- down
		end
	end
end,

Tick = function(timepassed)
	-- todo - do these lookups once in OnPlay?
	--local transform = this.gameobject:GetTransform();
	local collisionobject = this.gameobject:Get2DCollisionObject();

	--local pos = transform:GetPosition();
	--local rot = transform:GetLocalRotation();
	
	-- move the player
	this.dir = this.dir:Scale( this.Speed );
	--collisionobject:ApplyForce( this.dir, Vector2(0,0) );
	local velocity = collisionobject:GetLinearVelocity();
	local mass = collisionobject:GetMass();
	local forceneeded = this.dir:Sub( velocity ).x;
	forceneeded = forceneeded * mass;
	--if this.dir:Length() > 0 then
		collisionobject:ApplyLinearImpulse( Vector2(forceneeded, 0), Vector2(0,0) );
	--end
	
	if this.jump then
		local object = g_pComponentSystemManager:FindGameObjectByName( "Weight" );
		local newobject = g_pComponentSystemManager:CopyGameObject( object, "New Weight" );
		--newobject.ComponentTransform:SetPosition( Vector3( 6, 1, 0 ) );
		--collisionobject:ApplyLinearImpulse( Vector2(0,20), Vector2(0,0) );
	end

	-- zero out the input vector
	this.dir.x = 0;
	this.dir.y = 0;
	this.jump = false;
end,

OnCollision = function(normal)
	if( normal.y > 0 ) then
		this.jump = true;
	end
end,

}