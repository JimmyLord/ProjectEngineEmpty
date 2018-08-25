-- TestObjectPool_PooledObject Script

TestObjectPool_PooledObject =
{

OnLoad = function()
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
	local transform = this.gameobject:GetTransform();
	local pos = transform:GetLocalPosition();
	if( pos.y < -10 ) then
		this.gameobject:ReturnToPool();
	end
end

}
