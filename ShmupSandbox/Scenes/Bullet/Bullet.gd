extends Area2D
class_name Bullet

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

func get_class():
	return "Bullet"

func is_type(type): 
	return type == self.get_class or .is_type(type)


func _on_Bullet_area_entered(area):
	if(area== $HitboxPlayer):
		self.queue_free()
