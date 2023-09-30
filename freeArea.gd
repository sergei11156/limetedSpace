extends Node2D

var poly;

# Called when the node enters the scene tree for the first time.
func _ready():
	poly = Polygon2D.new()
	var screen_size = get_viewport_rect().size
	position = screen_size /2
	
	var verticePerUnits = 50
	
	var leftSide = []
	var leftSideX = -screen_size.x/2
	for y in range(screen_size.y/2, -screen_size.y/2, -verticePerUnits):
		leftSide.push_back(Vector2(leftSideX + (randi() % verticePerUnits - verticePerUnits/2), y))
	
	var topSide = []
	var topSideY = -screen_size.y/2
	for x in range(-screen_size.x/2, screen_size.x/2, verticePerUnits):
		topSide.push_back(Vector2(x, topSideY + (randi() % verticePerUnits - verticePerUnits/2)))
		
	var rightSide = []
	var rightSideX = screen_size.x/2
	for y in range(-screen_size.y/2, screen_size.y/2, verticePerUnits):
		rightSide.push_back(Vector2(rightSideX + (randi() % verticePerUnits - verticePerUnits/2), y))
	
	var bottomSide = []
	var bottomSideY = screen_size.y/2
	for x in range(screen_size.x/2, -screen_size.x/2, -verticePerUnits):
		bottomSide.push_back(Vector2(x, bottomSideY + (randi() % verticePerUnits - verticePerUnits/2)))
	
	var allSides = leftSide + topSide + rightSide + bottomSide
	
	poly.set_polygon(PackedVector2Array(allSides))
								
								
	
	
	var offset = 50;
	
	var vertice = Vertice.new(Vector2(-1152/2 + offset, 648/2 - offset))
	var vPos = vertice.getPosition()
	
	
	
	
	add_child(poly)
	poly.set_position(Vector2(0, 0))
	#scale = scale / 2	

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
