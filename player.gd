extends CharacterBody2D
var mousepositoion
@export var speed = 1000
var mouse_position = null
@export var reloadTime = .5
var waitReloadTime = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	startGame()

	
func _physics_process(delta):
	waitReloadTime += delta
	velocity = Vector2(0, 0)
	mouse_position = get_global_mouse_position()
	var deltaPosition = mouse_position - position;
	if deltaPosition.length() > 20:
		var direction = deltaPosition.normalized()
		velocity = (direction * speed)
		move_and_slide()
		look_at(mouse_position)
	

		
func is_shot_available():
	return reloadTime < waitReloadTime
	
func shotsFired():
	waitReloadTime = 0

func startGame():
	position = get_viewport_rect().size / 2
	waitReloadTime = 0


