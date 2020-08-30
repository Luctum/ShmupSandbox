extends Area2D
var velocity=Vector2(0,0)
export (bool) var isBulletFromPlayer = false


func start(_position, _direction, shootSpeed):
	self.position = _position
	self.rotation = _direction.angle()
	velocity = _direction * shootSpeed
	


func _process(_delta):
	self.position += velocity
	if (isBulletFromPlayer == true):
		self.rotation_degrees = 0


func _on_Visibility_screen_exited():
	self.queue_free()
