extends CharacterBody2D
var mousepositoion
@export var speed = 1000
var mouse_position = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


	
func _physics_process(delta):
	velocity = Vector2(0, 0)
	mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position).normalized()
	velocity = (direction * speed)
	move_and_slide()
	look_at(mouse_position)

func _on_area_entered(area):
	pass # Replace with function body.


func _on_area_exited(area):
	pass # Replace with function body.


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.


func _on_body_entered(body):
	pass # Replace with function body.


func _on_body_exited(body):
	pass # Replace with function body.


func _on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.


func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
