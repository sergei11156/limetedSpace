extends Node
@export var bulletScene: PackedScene
@export var bonusScene: PackedScene
@export var ammoScene: PackedScene

@export var colors: Array[Color]

var colorAlphaVelocity = 0
var colorAlpha = .25

var bonuses = []
# Called when the node enters the scene tree for the first time.
func _ready():
	$FreeArea.startGame()
	startGame()
	
func makeShot(pos, rot):
	$ShotFired.play()
	var bullet = bulletScene.instantiate()
	bullet.shotAt(pos, rot)
	add_child(bullet)


func rand(v):
	return v * ((randi() % 10 - 5) / 1000.0 + 1)


func startGame():
	$FreeArea.startGame()
	$Player.startGame()
	$CreateBonusTimer.start()
	$CreateAmmunition.start()
	for bonuse in bonuses:
		if bonuse != null:
			bonuse.queue_free()
	bonuses = []
	

func _on_free_area_player_hit_border():
	startGame()
	


func _on_create_bonus_timer_timeout():
	var bonus = bonusScene.instantiate()
	var radius = $FreeArea.averageRadius - $Player.maxDistanceToRadiusToGainReload 
	var v = rand_circle(radius, $FreeArea.averageRadius - $Player.maxDistanceToRadiusToGainReload)
	bonus.position = $FreeArea.center + v
	add_child(bonus)
	bonuses.push_back(bonus)
	

func rand_circle(radius, from := 0):
	return Vector2(randf_range(from, radius), 0).rotated(randf() * 2 * PI)


func _on_player_make_6_shot():
	for i in range(6):
		makeShot($Player.position, $Player.rotation + (i * (PI/3/6) - PI/3/6/2))


func _on_create_ammunition_timeout():
	var ammo = ammoScene.instantiate()
	var radius = $FreeArea.averageRadius 	
	var v = rand_circle(radius, $FreeArea.averageRadius - $Player.maxDistanceToRadiusToGainReload * 2)
	ammo.position = $FreeArea.center + v
	add_child(ammo)
	bonuses.push_back(ammo)


func _on_player_make_shot():
	makeShot($Player.position, $Player.rotation)
	$Player.shotsFired()


func _on_free_area_bullet_hit_border():
	$BorderTouched.play()
