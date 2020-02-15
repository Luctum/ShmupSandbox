extends Node2D

func _ready():
	pass

func _on_Enemy_shoot(bullet1, direction, position, shootSpeed):
	add_child(bullet1)
	bullet1.start(position, direction, shootSpeed)
