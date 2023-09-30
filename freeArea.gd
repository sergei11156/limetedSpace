extends Node2D

var screen_size
var radius
var vertices: Array[Vector2]

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
		var rnd1to100 = randi() % 100
		verticePos *= radius + rnd1to100
		print(step, verticePos)
		vertices.push_back(verticePos)
	
	var slices = [$PolygonSliece1, $PolygonSliece2, $PolygonSliece3, $PolygonSliece4]
	var collisionSlices = [$PolygonSliece1, $PolygonSliece2, $PolygonSliece3, $PolygonSliece4]
	
	drawVertices(vertices, slices)
	drawVertices(vertices, collisionSlices)
	

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
				print(vertice.normalized() * radius * 4, "first vertice, slice:", i / verticesInSlice - 1)
			else:
				polygonVertices.push_back(vertice.normalized() * radius * 4) # первая точка в слайсе
				print(vertice.normalized() * radius * 4, "first vertice, slice:", i / verticesInSlice - 1)
		
		polygonVertices.push_back(Vector2(vertice))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
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
