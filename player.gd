extends CharacterBody2D
var mousepositoion
@export var speed = 1000
var mouse_position = null

signal playerHitBorder

# Called when the node enters the scene tree for the first time.
func _ready():
	startGame()

	
func _physics_process(delta):
	velocity = Vector2(0, 0)
	mouse_position = get_global_mouse_position()
	var deltaPosition = mouse_position - position;
	if deltaPosition.length() > 20:
		var direction = deltaPosition.normalized()
		velocity = (direction * speed)
		move_and_slide()
		look_at(mouse_position)
	

func startGame():
	position = get_viewport_rect().size / 2

func onAreaTouch():
	playerHitBorder.emit()
