extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport_rect().size
	position = screen_size /2
	
	var verticePerUnits = 20
	
	var leftSide: Array[Vector2] = []
	var leftSideX = -screen_size.x/2
	for y in range(screen_size.y/2, -screen_size.y/2, -verticePerUnits):
		leftSide.push_back(Vector2(leftSideX + (randi() % verticePerUnits - verticePerUnits/2), y))
	
	var topSide: Array[Vector2] = []
	var topSideY = -screen_size.y/2
	for x in range(-screen_size.x/2, screen_size.x/2, verticePerUnits):
		topSide.push_back(Vector2(x, topSideY + (randi() % verticePerUnits - verticePerUnits/2)))
		
	var rightSide: Array[Vector2] = []
	var rightSideX = screen_size.x/2
	for y in range(-screen_size.y/2, screen_size.y/2, verticePerUnits):
		rightSide.push_back(Vector2(rightSideX + (randi() % verticePerUnits - verticePerUnits/2), y))
	
	var bottomSide: Array[Vector2] = []
	var bottomSideY = screen_size.y/2
	for x in range(screen_size.x/2, -screen_size.x/2, -verticePerUnits):
		bottomSide.push_back(Vector2(x, bottomSideY + (randi() % verticePerUnits - verticePerUnits/2)))
	
	var allSidesVertice = leftSide + topSide + rightSide + bottomSide
	
	
	$Polygon2D.set_polygon(PackedVector2Array(allSidesVertice))
	$Polygon2D.set_position(Vector2(0, 0))
	$Area2D/CollisionPolygon2D.set_position(Vector2(0, 0))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var poligon = $Polygon2D.get_polygon();
	for i in poligon.size():
		var deltaPosition = -poligon[i].normalized() * poligon[i].length() * 0.05 * delta;
		poligon.set(i, poligon[i] + deltaPosition);
	
	$Polygon2D.set_polygon(poligon)
	$Area2D/CollisionPolygon2D.set_polygon(poligon)
	




func _on_area_2d_area_entered(area):
	pass # Replace with function body.


func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.
