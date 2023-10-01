extends Node2D

var screen_size
var radius
var vertices
var verticesEffects = []
var slices
var collisionSlices
@export var verticesCount = 144
@export var effectLifetime = 1
@export var сollapseVelocity = 100
@export var maxEffectRadiusForCollision = 500.0
signal playerHitBorder


func _ready():
	screen_size = get_viewport_rect().size
	radius = (screen_size.x if screen_size.x > screen_size.y else screen_size.y) / 2 
	position = screen_size /2
	slices = [$PolygonSliece1, $PolygonSliece2, $PolygonSliece3, $PolygonSliece4]
	collisionSlices = [$Area2D/CollisionSliece1, $Area2D/CollisionSliece2, $Area2D/CollisionSliece3, $Area2D/CollisionSliece4]


func startGame():
	verticesEffects = []
	vertices = []
	for step in range(verticesCount):
		var verticePos = Vector2.from_angle(PI * 2 / verticesCount * step)
		verticePos *= radius
		vertices.push_back(verticePos)
	
	drawVertices(vertices, slices)
	drawVertices(vertices, collisionSlices)

func rand(v):
	return v * ((randi() % 10 - 5) / 500.0 + 1)
	
func drawVertices(vertices: Array, slices: Array):
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
func _physics_process(delta):
	vertices = vertices.map(func(v): return updateVertice(v, delta))
	drawVertices(vertices, slices)
	drawVertices(vertices, collisionSlices)
	updateEffectsLifetime(delta)	
	
	#var poligon = $Polygon2D.get_polygon();
	#for i in poligon.size():
	#	
	
	#$Polygon2D.set_polygon(poligon)
	#$Area2D/CollisionPolygon2D.set_polygon(poligon)
	

func updateEffectsLifetime(delta):
	var newEffects = []
	for effect in verticesEffects:
		effect["lifetime"] -= delta
		if effect["lifetime"] > 0:
			newEffects.push_back(effect)
	verticesEffects = newEffects


func updateVertice(v, delta):
	var deltaPosition = -v.normalized() * delta * сollapseVelocity;
	var newVerticePosition = v + deltaPosition
	newVerticePosition = applyEffects(newVerticePosition, delta)
	return newVerticePosition

func applyEffects(vertice, delta):
	for effect in verticesEffects:
		var effectRadius = effect["radius"] * (effect["lifetime"] / effectLifetime)
		var distanceBeetwen = (effect["position"] - vertice).length()
		if distanceBeetwen < effectRadius:
			vertice += distanceBeetwen/effectRadius * effect["impulse"] * vertice.normalized() * delta
	return vertice

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		playerHitBorder.emit()
	else:
		onBulletHitBorder(body)


func onBulletHitBorder(body):
	verticesEffects.push_back({
		"position": body.position - screen_size/2,
		"impulse": body.velocity.length() / 10,
		"lifetime": effectLifetime,
		"radius": maxEffectRadiusForCollision
	})
	body.queue_free()
	pass
	
