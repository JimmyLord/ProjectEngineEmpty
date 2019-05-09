-- test Script

VoxelWorldCamera =
{

Externs =
{
	-- name, type, initial value
	{ "Speed", "Float", 1 },
	{ "ObjectChasing", "GameObject", "Player" },
};

OnLoad = function(this)
	this.mousedirx = 0;
	this.mousediry = 0;

	this.anglex = 0;
	this.angley = 0;
end,

OnPlay = function(this)
	SetMouseLock( true );
end,

OnStop = function(this)
	SetMouseLock( false );
end,

OnTouch = function(this, action, id, x, y, pressure, size)

	--LogInfo( "OnTouch " .. x .. "\n" );
	
	if( action == 0 ) then --GCBA_Down
		SetMouseLock( true );
	end

	if( action == 4 ) then --GCBA_RelativeMovement
		this.mousedirx = x * -1;
		this.mousediry = y * -1;
	end

end,

OnButtons = function(this, action, id)
end,

Tick = function(this, deltaTime)

	-- Spin camera based on mouse x/y
	this.anglex = this.anglex + this.mousediry * 0.5;
	this.angley = this.angley + this.mousedirx * 0.5;

	this.mousedirx = 0;
	this.mousediry = 0;

	-- Update the camera object's transform
	local posChasing = this.ObjectChasing:GetTransform():GetLocalPosition();
	local camOffset = Vector3( 0, 1, -3 );

	local matrix = MyMatrix();
	matrix:SetIdentity();
	matrix:Translate( camOffset );
	matrix:Rotate( this.anglex, 1, 0, 0 );
	matrix:Rotate( this.angley, 0, 1, 0 );
	matrix:Translate( posChasing );

	this.gameobject:GetTransform():SetLocalTransform( matrix );

end

}
