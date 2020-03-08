extends Area2D


# Déclare la vitesse du vaisseau
export var speed = 200
export var isShooting = false
export var fireRate =  0.015

var screen_size  # Size of the game window.

# Déclare l'apparence des projectiles du joueur
var bulletType = load("res://Scenes/Bullet/BulletPlayer.tscn")
var mortExplosion = load("res://Scenes/Particules/mortExplosion.tscn")
var haveFired = false
var isFocused = false

signal shoot

#Permet d'obtenir de la RNG selon le temps
var rng = RandomNumberGenerator.new()

func _ready():
	screen_size = get_viewport_rect().size
	$shootingSpeedPlayer.wait_time = self.fireRate

	#Définit une Seed pour la RNG
	rng.randomize()

func playerShooting():
#	#Lorsque le joueur appuis sur la touche de tir
	if Input.is_action_just_pressed("ui_shoot"):
		shoot()
		$shootingSpeedPlayer.wait_time = fireRate
		$shootingSpeedPlayer.start()
		isShooting = true
	if Input.is_action_just_released("ui_shoot"):
		isShooting = false
		$shootingSpeedPlayer.stop()
	$shooting.visible = isShooting 

func shoot():
	#Définit l'angle
	var anglePlayerShoot
	if (isFocused == false) :
		anglePlayerShoot = rng.randf_range(-0.45, 0.45)
	else:
		anglePlayerShoot = rng.randf_range(-0.1, 0.1)
	emit_signal("shoot",bulletType.instance(),position,Vector2(anglePlayerShoot,-3),2)

func _on_shootingSpeedPlayer_timeout():
	shoot()

func _process(delta):
	#Commandes de Debugs / Confort Developpement
	#if Input.is_action_pressed("ui_esc"):
		
	playerShooting()
	focusPlayer()
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$moving.animation = "moving"
		$moving.speed_scale = 2
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$moving.speed_scale = 2
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		$moving.speed_scale = 2
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		$moving.speed_scale = 2
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$vaisseau.play()
	else:
		$vaisseau.stop()
		$moving.speed_scale = 1
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func focusPlayer():
	if Input.is_action_pressed("ui_focus"):
		speed = 100
		isFocused = true
		$Focus.emitting = true

	if Input.is_action_just_released("ui_focus"):
		speed = 200
		isFocused = false
		$Focus.emitting = false


# Quand un objet touche le joueur
func _on_Player_area_entered(area):
	print(area.get_class())
	if area.get_class() == "Bullet" && area.isBulletFromPlayer == false:
		self.visible=false
		emit_signal("visibility_changed")
		mortExplosion.instance()
		print(area.name)
		queue_free()

func get_class():
	return "Player"
	
func is_type(type): 
	return type == self.get_class or .is_type(type)



