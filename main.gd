extends Node
@export var bulletScene: PackedScene
var loadIndicators = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$FreeArea.startGame()
	loadIndicators = [$ColorRect2, $ColorRect3, $ColorRect4]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("shot"):
		if $Player.is_shot_available():
			var bullet = bulletScene.instantiate()
			bullet.shotAt($Player.position, $Player.rotation)
			add_child(bullet)
			$Player.shotsFired()
			
	
	for i in range($Player.availableShots):
		loadIndicators[i].set_color(Color(1, 1, 1))
	
	if $Player.availableShots < loadIndicators.size():
		var color = $Player.shotProgress
		loadIndicators[$Player.availableShots].set_color(Color(color, color, color))
		for i in range($Player.availableShots + 1, loadIndicators.size()):
			loadIndicators[i].set_color(Color(0, 0, 0))
			

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
	
