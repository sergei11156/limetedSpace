extends Node2D

var poly;

# Called when the node enters the scene tree for the first time.
func _ready():
	poly = Polygon2D.new()
	var screen_size = get_viewport_rect()
	var offset = 50;
	
	poly.set_polygon(PackedVector2Array([Vector2(-1152/2 + offset, 648/2 - offset),
								  Vector2(-1152/2 + offset, -648/2 + offset),
								  Vector2(1152/2 - offset, -648/2 + offset),
								  Vector2(1152/2 - offset, 648/2 - offset)
								]))
								
	
								
	
	add_child(poly)
	var pos = poly.get_position()
	poly.set_position(Vector2(offset/2, 0))
	pass # Replace with function body.

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
