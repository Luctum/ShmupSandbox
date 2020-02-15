extends Node

signal shoot()

export (float) var shootDelay = 0.5
export (float) var shootSpeed = 1
export (Vector2) var movementDirection = Vector2(0,0)
export var rotateShoot = false
export var rotationSpeed = 5
export var life = 3

var bulletType = load("res://Scenes/Bullet/Bullet.tscn")

func _ready():
	$Shootingspeed.wait_time = shootDelay
	
func _on_Shootingspeed_timeout():
	var bullet = bulletType.instance()
	var direction = Vector2(0,1).rotated($EnemySprite/Shooter.rotation)
	var position = self.global_position
	emit_signal("shoot", bullet, direction, position, shootSpeed)

func _process(delta):
	self.position += movementDirection
	if rotateShoot :
		$EnemySprite/Shooter.rotation_degrees += rotationSpeed
		# Prevent the rotation to go to an infinite value
		if $EnemySprite/Shooter.rotation_degrees == 360:
			$EnemySprite/Shooter.rotation_degrees = 0
	
func hit():
	life -= 1

func die():
	self.visible = false
