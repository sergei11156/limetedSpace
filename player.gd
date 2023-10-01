extends CharacterBody2D
var mousepositoion
@export var speed = 1000
var mouse_position = null
@export var reloadTime = .5
var waitReloadTime = 0
var availableShots = 0
var maxShots = 3
var shotProgress
@export var maxDistanceToRadiusToGainReload = 300

signal make6Shot
func _ready():
	var vertices = []
	for step in range(20):
		var verticePos = Vector2.from_angle(PI * 2 / 20 * step)
		verticePos *= 65
		vertices.push_back(verticePos)
	
	$PlayerPolygon.set_polygon(PackedVector2Array(vertices))
	startGame()

func updateReloadTime(delta, avgRadius, center):
		var len = abs((position - center).length() - avgRadius)
		if len < maxDistanceToRadiusToGainReload and velocity.length() > 0:
			waitReloadTime += delta * len / maxDistanceToRadiusToGainReload		
	
func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	var deltaPosition = mouse_position - position;
	if deltaPosition.length() > 50:
		var direction = deltaPosition.normalized()
		velocity = (direction * speed)
	else:
		velocity = Vector2(0, 0)
	
	if waitReloadTime > reloadTime:
		availableShots += 1
		waitReloadTime = 0
		
		if availableShots > maxShots:
			availableShots = maxShots
	
	
	shotProgress = waitReloadTime / reloadTime
	
	var max_color = .5
	var color_value = max_color - (1 if shotProgress > 1 else shotProgress) * max_color
	$PlayerPolygon.set_color(Color(color_value, color_value, color_value))
	
	move_and_slide()
	look_at(mouse_position)

		
func is_shot_available():
	return availableShots > 0
	
func shotsFired():
	availableShots -= 1

func startGame():
	position = get_viewport_rect().size / 2
	waitReloadTime = 0
	availableShots = 0

func makeSixShot():
	make6Shot.emit()


