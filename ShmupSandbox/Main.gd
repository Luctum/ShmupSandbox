extends Node2D

func _ready():
	pass

func _on_Enemy_shoot(bullet1, bullet2, direction, position):
	add_child(bullet1)
	add_child(bullet2)
	var toto = position + transform.x * 35
	bullet1.start(toto, direction)
	bullet2.start(position, direction)
