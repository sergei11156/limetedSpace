extends Node
@export var bulletScene: PackedScene
@export var bonusScene: PackedScene

var loadIndicators = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$FreeArea.startGame()
	loadIndicators = [$ColorRect2, $ColorRect3, $ColorRect4]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shot"):
		if $Player.is_shot_available():
			makeShot($Player.position, $Player.rotation)
			$Player.shotsFired()
			
	
	for i in range($Player.availableShots):
		loadIndicators[i].set_color(Color(1, 1, 1))
	
	if $Player.availableShots < loadIndicators.size():
		var color = $Player.shotProgress
		loadIndicators[$Player.availableShots].set_color(Color(color, color, color))
		for i in range($Player.availableShots + 1, loadIndicators.size()):
			loadIndicators[i].set_color(Color(0, 0, 0))
			
func makeShot(pos, rot):
	var bullet = bulletScene.instantiate()
	bullet.shotAt(pos, rot)
	add_child(bullet)

func _physics_process(delta):
	$Player.updateReloadTime(delta, $FreeArea.averageRadius, $FreeArea.center)
	var vertices = []
	for step in range(40):
		var verticePos = Vector2.from_angle(PI * 2 / 40 * step)
		verticePos *= $FreeArea.averageRadius - $Player.maxDistanceToRadiusToGainReload
		vertices.push_back(rand(verticePos))
	
	$WithoutReloadZone.position = $FreeArea.center
	$WithoutReloadZone.set_polygon(PackedVector2Array(vertices))

func rand(v):
	return v * ((randi() % 10 - 5) / 1000.0 + 1)
	
func _on_free_area_player_hit_border():
	$FreeArea.startGame()
	$Player.startGame()
	


func _on_create_bonus_timer_timeout():
	var bonus = bonusScene.instantiate()
	var rand = randi() % int($FreeArea.averageRadius - $Player.maxDistanceToRadiusToGainReload) 
	var v = Vector2(rand, rand)
	bonus.position = $FreeArea.center + v
	add_child(bonus)
	


func _on_player_make_6_shot():
	for i in range(6):
		makeShot($Player.position, $Player.rotation + (i * (PI/3/6) - PI/3/6/2))
