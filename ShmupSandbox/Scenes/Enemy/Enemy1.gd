extends Area2D

signal shoot()
signal enemyDie()
export (float) var shootDelay = 0.15
export (float) var shootSpeed = 5
export (float) var randomVariation = 0
export (Vector2) var movementDirection = Vector2(0,0)
export var rotateShoot = false
export var rotationSpeed = 5
export var life = 3

var bulletType = load("res://Scenes/Bullet/Bullet.tscn")
var mortExplosion = load("res://Scenes/Particules/mortExplosion.tscn")

func _ready():
	$Shootingspeed.wait_time = shootDelay
	
func _on_Shootingspeed_timeout():
	var bullet = bulletType.instance()
	var direction = Vector2(0,1).rotated($EnemySprite/Shooter.rotation)
	var position = self.global_position
	emit_signal("shoot", bullet, direction, position, shootSpeed)

func _process(_delta):
	self.position += movementDirection
	if rotateShoot :
		$EnemySprite/Shooter.rotation_degrees += rotationSpeed
		# Prevent the rotation to go to an infinite value
		if $EnemySprite/Shooter.rotation_degrees == 360:
			$EnemySprite/Shooter.rotation_degrees = 0
	
func hit():
	life -= 1
	if(life) == 0:
		self.die()

func die():
	self.visible = false
	emit_signal("enemyDie",self.position,mortExplosion.instance())
	queue_free()

# Quand un tir du joueur touche l'ennemi
func _on_Enemy_area_entered(area):
	if area.isBulletFromPlayer == true:
		self.hit()
		print(area.name)
		print(self.life)




