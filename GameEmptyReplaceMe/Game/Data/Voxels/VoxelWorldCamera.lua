-- test Script

VoxelWorldCamera =
{

Externs =
{
	-- name, type, initial value
	{ "Speed", "Float", 1 },
	{ "ObjectChasing", "GameObject", "Player" },
};

OnLoad = function()
	this.lastmousex = -1;
	this.lastmousey = -1;

	this.mousedirx = 0;
	this.mousediry = 0;

	this.anglex = 0;
	this.angley = 0;
end,

OnPlay = function()
end,

OnStop = function()
end,

OnTouch = function(action, id, x, y, pressure, size)

	--LogInfo( "OnTouch " .. this.mousedirx .. "\n" );

	this.mousedirx = (x - this.lastmousex) * -1;
	this.mousediry = (y - this.lastmousey) * 1;

	--this.lastmousex = x;
	--this.lastmousey = y;

	SetMousePosition( 640/2, 960/2 );
	this.lastmousex = 640/2;
	this.lastmousey = 960/2;

end,

OnButtons = function(action, id)
end,

Tick = function(timepassed)

	-- Spin camera based on mouse x/y
	this.anglex = this.anglex + this.mousediry / 10;
	this.angley = this.angley + this.mousedirx / 10;

	this.mousedirx = 0;
	this.mousediry = 0;

	-- Update the camera's matrix
	local posChasing = this.ObjectChasing:GetTransform():GetLocalPosition();
	local camOffset = Vector3( 0, 1, -3 );

	local matrix = this.gameobject:GetTransform():GetLocalTransform();
	matrix:SetIdentity();
	matrix:Translate( camOffset );
	matrix:Rotate( this.anglex, 1, 0, 0 );
	matrix:Rotate( this.angley, 0, 1, 0 );
	matrix:Translate( posChasing );

end

}
