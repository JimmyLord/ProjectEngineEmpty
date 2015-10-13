-- MemoryTest script - trying to track garbage generation.

MemoryTest =
{

Externs =
{
	-- name, type, initial value
	--{ "Speed", "Float", 1 },
	--{ "ObjectChasing", "GameObject", "Player Object" },
};

OnPlay = function()
	--LogInfo( "OnPlay\n" );
end,

OnStop = function()
	--LogInfo( "OnStop\n" );
end,

OnTouch = function(action, id, x, y, pressure, size)
	--LogInfo( "OnTouch\n" );
end,

OnButtons = function(action, id)
	--LogInfo( "OnButtons\n" );
end,

Tick = function(timepassed)
	--LogInfo( "Tick Start\n" );
	--LogInfo( "System time: " .. GetSystemTime() .. "\n" );

	--local value = GetSystemTime();

	--local transform = this.gameobject:GetTransform();

	--local pos = transform:GetPosition();
	local posChasing = Vector3( 320, 480, 0 ); --this.ObjectChasing:GetTransform():GetPosition();

	--posChasing.x = posChasing.x + math.cos( GetSystemTime() ) * 200;
	--posChasing.y = posChasing.y + math.sin( GetSystemTime() ) * 200;
	
	--local diff = posChasing:Sub( pos );
	--diff = diff:Scale( timepassed * 10 );--this.Speed );
	
	--pos = pos:Add( diff );

	--transform:SetPosition( pos );
	
	--local memusage = collectgarbage("count");
	--LogInfo( "Lua memory usage: " .. memusage .. "\n" );

	--obj = ComponentSystemManager:CreateGameObject( true );
	--ComponentSystemManager:DeleteGameObject( obj );
	--ComponentSystemManager:CopyGameObject( this.gameobject, "Dupe" );
	--obj = ComponentSystemManager:FindGameObjectByName( "Player Object" );

	--LogInfo( "Tick End\n" );
end,

}