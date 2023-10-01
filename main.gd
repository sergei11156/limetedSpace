extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$FreeArea.startGame()	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_player_hit_border():
	$FreeArea.startGame()
	$Player.startGame()
