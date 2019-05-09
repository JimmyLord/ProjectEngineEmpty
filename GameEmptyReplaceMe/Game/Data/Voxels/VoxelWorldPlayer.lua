-- test script

VoxelWorldPlayer =
{

Externs =
{
	-- name, type, initial value
	{ "Speed", "Float", 10 },
	{ "SpeedRotation", "Float", 10 },
	{ "Animation", "Float", 1 },
	{ "VoxelWorldGameObject", "GameObject", "VoxelWorld" },
};

OnLoad = function(this)
end,

OnPlay = function(this)
	-- math.randomseed( os.time() );

	-- initialize some local variables
	this.dir = Vector3(0,0,0);
	this.targetangle = 0;
	this.buttonsheld = {}
	this.buttonsheld[1] = false; --GCBI_Left
	this.buttonsheld[2] = false; --GCBI_Right
	this.buttonsheld[3] = false; --GCBI_Up
	this.buttonsheld[4] = false; --GCBI_Down
end,

OnStop = function(this)
end,

OnTouch = function(this, action, id, x, y, pressure, size)
	-- LogInfo( "OnTouch " .. id .. "\n" );
end,

OnButtons = function(this, action, id)
	-- LogInfo( "OnButtons " .. id .. "\n" );

	if( action == 0 ) then -- GCBA_Down - button held
		this.buttonsheld[id] = true;
	end

	if( action == 1 ) then -- GCBA_Up - button held
		this.buttonsheld[id] = false;
	end

	--if( action == 2 ) then -- GCBA_Held - button held
	--	if( id == 1 ) then -- GCBI_Left - left
	--		inputdegrees = inputdegrees + 270; --this.dir.x = -1;
	--	end
	--	if( id == 2 ) then -- GCBI_Right - right
	--		inputdegrees = inputdegrees + 90; --this.dir.x = 1;
	--	end
	--	if( id == 3 ) then -- GCBI_Up - up
	--		inputdegrees = inputdegrees + 0; --this.dir.z = 1;
	--	end
	--	if( id == 4 ) then -- GCBI_Down - down
	--		inputdegrees = inputdegrees + 180; --this.dir.z = -1;
	--	end
	--end

end,

Tick = function(this, deltaTime)
	
	-- LogInfo( "Tick " .. deltaTime .. "\n" );

	-- todo - do these 3 lookups once in OnPlay?
	local cameraobject = ComponentSystemManager:FindGameObjectByName( "Main Camera" );
	local animplayer = this.gameobject:GetAnimationPlayer();
	local transform = this.gameobject:GetTransform();

	-- Figure out the direction the player is moving
	this.dir.x = 0;
	this.dir.z = 0;

	if( this.buttonsheld[1] == true ) then -- GCBI_Left
		this.dir.x = -1;
	end
	if( this.buttonsheld[2] == true ) then -- GCBI_Right
		this.dir.x = 1;
	end
	if( this.buttonsheld[3] == true ) then -- GCBI_Up
		this.dir.z = 1;
	end
	if( this.buttonsheld[4] == true ) then -- GCBI_Down
		this.dir.z = -1;
	end

	-- Rotate inputs based on camera angle
	if( this.dir.x ~= 0 or this.dir.z ~= 0 ) then
		-- Turn x/z dir into angle
		local inputradians = math.atan( this.dir.z, this.dir.x * -1 ) - math.pi/2;

		-- Get camera angle
		local camroty = cameraobject:GetTransform():GetLocalRotation().y * -1;
		local camradians = camroty / 180 * math.pi;

		-- Turn angle back into x/z dir
		this.dir.x = math.sin( inputradians + camradians );
		this.dir.z = math.cos( inputradians + camradians );
	end

	-- play the correct animation and figure out facing direction based on input.
	if( this.dir.x ~= 0 or this.dir.z ~= 0 ) then
		this.targetangle = math.atan( this.dir.z, this.dir.x ) / math.pi * 180 - 90;
		this.Animation = 1;
	else
		this.Animation = 0;
	end

	-- move the player
	local pos = transform:GetLocalPosition();
	local rot = transform:GetLocalRotation();

	this.dir:Normalize(); -- avoid fast diagonals.
	pos.x = pos.x + this.dir.x * deltaTime * this.Speed;
	pos.z = pos.z + this.dir.z * deltaTime * this.Speed;

	-- snap the y pos to the terrain
	local voxelworld = this.VoxelWorldGameObject:GetVoxelWorld();
	local groundy = voxelworld:GetSceneYForNextBlockBelowPosition( pos, 0.1 );
	pos.y = groundy + 0.8;

	-- rotate towards the target angle
	local anglediff = this.targetangle - rot.y;
	if( anglediff > 180 ) then anglediff = anglediff - 360;	end
	if( anglediff < -180 ) then anglediff = anglediff + 360; end
	--LogInfo( "rot.y " .. rot.y .. " " .. "this.targetangle " .. this.targetangle .. " " .. "anglediff " .. anglediff .. "\n" );
	rot.y = rot.y + anglediff * deltaTime * this.SpeedRotation;
	rot.y = rot.y % 360;

	-- set the new position and rotation values
	transform:SetLocalPosition( pos );
	transform:SetLocalRotation( rot );

	-- set the current animation
	if( animplayer ) then
		animplayer:SetCurrentAnimation( this.Animation );
	end

end,

}