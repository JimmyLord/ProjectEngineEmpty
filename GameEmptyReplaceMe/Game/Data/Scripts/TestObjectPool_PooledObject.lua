-- TestObjectPool_PooledObject Script

TestObjectPool_PooledObject =
{

OnLoad = function(this)
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
	local transform = this.gameobject:GetTransform();
	local pos = transform:GetLocalPosition();
	if( pos.y < -10 ) then
		this.gameobject:ReturnToPool();
	end
end

}
