extends Area2D

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

export var shooting = false

func _ready():
	screen_size = get_viewport_rect().size
	


func playerShooting():
	if Input.is_action_pressed("ui_shoot"):
		shooting = true
		$shooting.visible = true
	else:
		shooting = false
		$shooting.visible = false

func _process(delta):
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
		speed = 150
	if Input.is_action_just_released("ui_focus"):
		speed = 400


	
