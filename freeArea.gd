extends Node2D

var poly;

# Called when the node enters the scene tree for the first time.
func _ready():
	poly = Polygon2D.new()
	var screen_size = get_viewport_rect().size
	var xsize = screen_size.x
	var offset = 50;
	
	var vertice = Vertice.new(Vector2(-1152/2 + offset, 648/2 - offset))
	var vPos = vertice.getPosition()
	
	
	poly.set_polygon(PackedVector2Array([Vector2(-screen_size.x/2 + offset, screen_size.y/2 - offset),
								  Vector2(-screen_size.x/2 + offset, -screen_size.y/2 + offset),
								  Vector2(screen_size.x/2 - offset, -screen_size.y/2 + offset),
								  Vector2(screen_size.x/2 - offset, screen_size.y/2 - offset)
								]))
								
								
	
	add_child(poly)
	var pos = poly.get_position()
	poly.set_position(Vector2(screen_size.x/2, screen_size.y/2))
	pass # Replace with function body.

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
