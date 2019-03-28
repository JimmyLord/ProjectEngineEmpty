-- test Player script, moves to where you click.

Player =
{

OnLoad = function()
    -- TODO: adds ref each time script is loaded, and nothing removes them.
	--FileManager:RequestFile( "Data/OBJs/Teapot.obj" );
end,

OnPlay = function ()
	--LogInfo( "OnPlay\n" );
end,

OnStop = function ()
	--LogInfo( "OnStop\n" );
end,

OnTouch = function(action, id, x, y, pressure, size)
	--LogInfo( "OnTouch\n" );
	local transform = this.gameobject:GetTransform();
	local pos = transform:GetLocalPosition();

	-- finger down
	if( action == 0 ) then
		--this.id = this.gameobject.id;
		--LogInfo( "setID: " .. this.id .. "\n" );
	end

	-- finger up
	if( action == 1 ) then
		--LogInfo( "ID: " .. this.id .. "\n" );
	end
	
	--LogInfo( "pos: " .. x .. " " .. y .. "\n" );

	pos.x = x;
	pos.y = y;

	transform:SetLocalPosition( pos );
end,

OnButtons = function(action, id)
	--LogInfo( "OnButtons\n" );
end,

Tick = function (deltaTime)
	--LogInfo( "Tick Start\n" );

	--transform = this.gameobject:GetTransform();
	--pos = transform:GetLocalPosition();

	--speed = 100;
	--pos.x = pos.x + deltaTime*speed;
	
	--transform:SetLocalPosition( pos );
	
	--LogInfo( "Tick End\n" );
end,

}