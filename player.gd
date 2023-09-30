extends CharacterBody2D
var mousepositoion
@export var speed = 1000
var mouse_position = null

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_viewport_rect().size / 2


	
func _physics_process(delta):
	velocity = Vector2(0, 0)
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position).normalized()
	velocity = (direction * speed)
	move_and_slide()
	look_at(mouse_position)
