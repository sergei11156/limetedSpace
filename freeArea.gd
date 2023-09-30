extends Node2D

var poly;

# Called when the node enters the scene tree for the first time.
func _ready():
	poly = Polygon2D.new()
	var screen_size = get_viewport_rect().size
	position = screen_size /2
	
	var verticePerUnits = 50
	
	var leftSide: Array[Vertice] = []
	var leftSideX = -screen_size.x/2
	for y in range(screen_size.y/2, -screen_size.y/2, -verticePerUnits):
		var vertice = Vertice.new(Vector2(leftSideX + (randi() % verticePerUnits - verticePerUnits/2), y))
		leftSide.push_back(vertice)
	
	var topSide: Array[Vertice] = []
	var topSideY = -screen_size.y/2
	for x in range(-screen_size.x/2, screen_size.x/2, verticePerUnits):
		var vertice = Vertice.new(Vector2(x, topSideY + (randi() % verticePerUnits - verticePerUnits/2)))
		topSide.push_back(vertice)
		
	var rightSide: Array[Vertice] = []
	var rightSideX = screen_size.x/2
	for y in range(-screen_size.y/2, screen_size.y/2, verticePerUnits):
		var vertice = Vertice.new(Vector2(rightSideX + (randi() % verticePerUnits - verticePerUnits/2), y))
		rightSide.push_back(vertice)
	
	var bottomSide: Array[Vertice] = []
	var bottomSideY = screen_size.y/2
	for x in range(screen_size.x/2, -screen_size.x/2, -verticePerUnits):
		var vertice = Vertice.new(Vector2(x, bottomSideY + (randi() % verticePerUnits - verticePerUnits/2)))		
		bottomSide.push_back(vertice)
	
	var allSidesVertice: Array[Vertice] = leftSide + topSide + rightSide + bottomSide
	
	
	poly.set_polygon(PackedVector2Array(allSidesVertice.map(func(v): return v.getPosition())))
	
	
	add_child(poly)
	poly.set_position(Vector2(0, 0))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
