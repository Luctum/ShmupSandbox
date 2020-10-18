extends Area2D
class_name Player
signal shoot

var random_seed = RandomNumberGenerator.new()

######################################
######### EXTERNAL RESOURCES #########
######################################
var bulletType = load("res://Scenes/Bullet/BulletPlayer.tscn")
var mortExplosion = load("res://Scenes/Particules/mortExplosion.tscn")

######################################
######### PLAYER STATS/VALUES#########
######################################

export var inventory = {
	bombs = 3,
}

export var state = {
	is_shooting = false,
	have_fired = false,
	is_focused = false
}

export var statistics = {
	movement_speed = 200,
	fire_rate =  0.1	
}

######################################
############## SCENE #################
######################################

func _ready():
	$shootingSpeedPlayer.wait_time = self.statistics.fire_rate
	random_seed.randomize()

func _process(delta):
	manage_movement_input(delta)
	manage_focus_input()
	manage_bomb_input()
	manage_shoot_input()

######################################
########## SECTION : INPUTS ##########
######################################

func manage_focus_input():
	if Input.is_action_pressed("ui_focus"):
		self.state.is_focused = true
		$Focus.emitting = true
	if Input.is_action_just_released("ui_focus"):
		self.state.is_focused = false
		$Focus.emitting = false


func manage_bomb_input():
	if Input.is_action_just_pressed("ui_bomb"):
		self.use_bomb();

func manage_shoot_input():
#	#Lorsque le joueur appuis sur la touche de tir
	if Input.is_action_just_pressed("ui_shoot"):
		shoot()
		$shootingSpeedPlayer.wait_time = self.statistics.fire_rate
		$shootingSpeedPlayer.start()
		self.state.is_shooting = true
	if Input.is_action_just_released("ui_shoot"):
		self.state.is_shooting = false
		$shootingSpeedPlayer.stop()
	$shooting.visible = self.state.is_shooting 

func manage_movement_input(delta):
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
	move(velocity, delta)

######################################
########## SECTION : ACTIONS #########
######################################

func shoot():
	#Définit l'angle
	var shooting_angle
	if (state.is_focused == false) :
		shooting_angle = self.random_seed.randf_range(-0.45, 0.45)
	else:
		shooting_angle = self.random_seed.randf_range(-0.1, 0.1)
	emit_signal("shoot",bulletType.instance(),position,Vector2(shooting_angle,-3),2)

func use_bomb():
	if (self.inventory.bombs > 0):
			self.inventory.bombs -=1
			get_tree().call_group("enemy_bullet", "queue_free")
			get_tree().call_group("enemies","die")

func move(velocity, delta):
	var current_speed = self.statistics.movement_speed
	if state.is_focused:
		current_speed = current_speed / 2;
	if velocity.length() > 0:
		velocity = velocity.normalized() * current_speed
		$vaisseau.play()
	else:
		$vaisseau.stop()
		$moving.speed_scale = 1
	position += velocity * delta
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)

#######################################
########## SECTION : SIGNALS ##########
#######################################

# Quand un objet touche le joueur
func _on_Player_area_entered(area):
	print(area.get_class())
	if area.get_class() == "Bullet" && area.isBulletFromPlayer == false:
		self.visible=false
		emit_signal("visibility_changed")
		mortExplosion.instance()
		print(area.name)
		queue_free()
	if area.get_class()=="CirclePowerUpLowDistance":
		inventory.bombs+=1

func _on_shootingSpeedPlayer_timeout():
	shoot()

######################################
########## SECTION : UTILS ###########
######################################

func get_class():
	return "Player"
	
func is_type(type): 
	return type == self.get_class or .is_type(type)




