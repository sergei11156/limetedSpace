extends Node2D

var screen_size
var radius
var vertices
var slices
var collisionSlices

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	radius = (screen_size.x if screen_size.x > screen_size.y else screen_size.y) / 2 
	
	position = screen_size /2
	
	var verticesCount = 144
	var randomOffset = 0.05 * radius
	vertices = []
	
	for step in range(verticesCount):
		var verticePos = Vector2.from_angle(PI * 2 / verticesCount * step)
		verticePos *= radius
		vertices.push_back(verticePos)
	
	
	slices = [$PolygonSliece1, $PolygonSliece2, $PolygonSliece3, $PolygonSliece4]
	collisionSlices = [$Area2D/CollisionSliece1, $Area2D/CollisionSliece2, $Area2D/CollisionSliece3, $Area2D/CollisionSliece4]
	#print(vertices)

	var randVertices = vertices.map(rand)
	
	drawVertices(randVertices, slices)
	drawVertices(randVertices, collisionSlices)
	
func rand(v):
	return v * ((randi() % 10 - 5) / 500.0 + 1)
	
func drawVertices(vertices: Array, slices: Array, ):
	var verticesInSlice = vertices.size()/slices.size()
	var polygonVertices = []
	for i in vertices.size() + 1:
		var vertice: Vector2
		if vertices.size() < i:
			vertice = vertices[i]
		else:
			vertice = vertices[i-1]
		if i % verticesInSlice == 0:
			if polygonVertices.size() > 0:
				#Если это последний слайс то
				polygonVertices.push_back(Vector2(vertice))
				polygonVertices.push_back(vertice.normalized() * radius * 4) # последняя точка в слайсе
				slices[i / verticesInSlice - 1].set_polygon(PackedVector2Array(polygonVertices))
				polygonVertices = []
				polygonVertices.push_back(vertice.normalized() * radius * 4) # первая точка в слайсе
			else:
				polygonVertices.push_back(vertice.normalized() * radius * 4) # первая точка в слайсе
		
		polygonVertices.push_back(Vector2(vertice))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var randVertices = vertices.map(rand)
	drawVertices(randVertices, slices)
	drawVertices(randVertices, collisionSlices)
	#var poligon = $Polygon2D.get_polygon();
	#for i in poligon.size():
	#	var deltaPosition = -poligon[i].normalized() * poligon[i].length() * 0.05 * delta;
	#	poligon.set(i, poligon[i] + deltaPosition * (1 + (randi() % 10)/100));
	
	#$Polygon2D.set_polygon(poligon)
	#$Area2D/CollisionPolygon2D.set_polygon(poligon)
	




func _on_area_2d_area_entered(area):
	pass # Replace with function body.


func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	print(body)
	pass # Replace with function body.


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.


func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
