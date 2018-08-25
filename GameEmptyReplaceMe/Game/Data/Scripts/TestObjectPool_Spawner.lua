-- TestObjectPool_Spawner Script

TestObjectPool_Spawner =
{

OnLoad = function()
end,

OnPlay = function()
	this.timeTilNextSpawn = 0.5;
end,

OnStop = function()
end,

OnTouch = function(action, id, x, y, pressure, size)
end,

OnButtons = function(action, id)
end,

Tick = function(deltaTime)
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
