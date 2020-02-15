extends Node2D

export(Texture) var image = preload("res://Assets/bullet_ennemi/bullet_ennemi.png")

var velocity

func _ready():
	$Bullet.texture = image

func start(_position, _direction, shootSpeed):
	self.position = _position
	self.rotation = _direction.angle()
	velocity = _direction * shootSpeed

func _process(delta):
	self.position += velocity
