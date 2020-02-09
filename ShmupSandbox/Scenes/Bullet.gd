extends Node2D

export(Texture) var image = preload("res://Assets/bullet_ennemi/bullet_ennemi.png")
export var x = 0
export var y = 0

	
func _ready():
	$Bullet.texture = image
	
func _process(delta):
	self.position += Vector2(x, y)
