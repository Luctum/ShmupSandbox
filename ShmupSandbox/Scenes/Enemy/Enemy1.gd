extends Node2D

var Bullet = load("res://Scenes/Bullet.tscn")
export (float) var shootDelay = 0.5

var x = 1
var y = 1

func _ready():
	$Shootingspeed.wait_time = shootDelay
	

func _on_Shootingspeed_timeout():
	var bullet = Bullet.instance()
	var bullet2 = Bullet.instance()
	
	bullet.position = $Enemy.position
	bullet2.position = $Enemy.position
	bullet2.position -= transform.x * 30
	
	add_child(bullet)
	add_child(bullet2)
