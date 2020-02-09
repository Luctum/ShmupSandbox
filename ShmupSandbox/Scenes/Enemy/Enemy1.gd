extends Node2D

export (float) var shootDelay = 0.5
export (Vector2) var movementDirection = Vector2(1,0)
export var rotateShoot = false
export var rotationShootSpeed = 5

var bulletType = load("res://Scenes/Bullet.tscn")

var life = 3
func _ready():
	$Shootingspeed.wait_time = shootDelay
	$Enemy/Shooter.position = $Enemy.position
	
func _on_Shootingspeed_timeout():
	var bullet = bulletType.instance()
	var bullet2 = bulletType.instance()
	
	var shooterPositon = $Enemy/Shooter.position
	var yOffset = transform.y * 35
	
	bullet.position = shooterPositon
	bullet.position += transform.x * 7
	bullet.position += yOffset
	bullet2.position = shooterPositon
	bullet2.position -= transform.x * 20
	bullet2.position += yOffset

	add_child(bullet)
	add_child(bullet2)

func _process(delta):
	self.position += movementDirection
	if rotateShoot :
		$Enemy/Shooter.rotation_degrees += rotationShootSpeed
		print($Enemy/Shooter.rotation_degrees)
		if $Enemy/Shooter.rotation_degrees == 180:
			$Enemy/Shooter.rotation_degrees = 0

func hit():
	life -= 1
	$Enemy.self_modulate = Color(100,100,100)
	$Enemy.self_modulate = Color(1,1,1)

func die():
	self.visible = false
