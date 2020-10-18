extends Node2D
class_name powerUp
signal powerup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_Area2D_area_entered(area):
	if(area.name=="HitboxPlayerArea"):
		emit_signal("powerup")

func pickupAllPowerups():
	print("PowerUp Récupéré.")
	print("méthode pickupAllPowerups activée")
	$RigidBody2D/Area2D/CollisionShape2D.set("scale",300)
	emit_signal("powerup")
	self.queue_free()


func _on_powerUp_powerup():
	#Fonction permettant de récupérer les objets :
	self.queue_free()
	pass # Replace with function body.
