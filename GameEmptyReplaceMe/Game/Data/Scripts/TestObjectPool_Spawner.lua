-- TestObjectPool_Spawner Script

TestObjectPool_Spawner =
{

OnLoad = function(this)
end,

OnPlay = function(this)
	this.timeTilNextSpawn = 0.5;
end,

OnStop = function(this)
end,

OnTouch = function(this, action, id, x, y, pressure, size)
end,

OnButtons = function(this, action, id)
end,

Tick = function(this, deltaTime)
	this.timeTilNextSpawn = this.timeTilNextSpawn - deltaTime;

	if( this.timeTilNextSpawn <= 0 ) then
		this.timeTilNextSpawn = 0.5
        local newObject = this.gameobject:GetObjectPool():GetObjectFromPool();
		if( newObject ~= nil ) then
			--local transform = newObject:GetTransform();
			--local pos = transform:GetLocalPosition();
			--pos.y = 0;
			--transform:SetLocalPosition( pos );

			local collisionObject = newObject:Get2DCollisionObject();
			collisionObject:ClearVelocity();
			collisionObject:SetPositionAndAngle( Vector2(0,10), 0 );

			newObject:SetEnabled( true, true );
		end
    end
end

}
