extends Node
@export var bulletScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$FreeArea.startGame()	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shot"):
		var bullet = bulletScene.instantiate()
		bullet.shotAt($Player.position, $Player.rotation)
		
		add_child(bullet)


func _on_free_area_player_hit_border():
	$FreeArea.startGame()
	$Player.startGame()
	
