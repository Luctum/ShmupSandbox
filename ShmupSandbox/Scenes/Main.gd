extends Node2D

func _ready():
	$AudioStreamPlayer.playing=true
func _on_Enemy_shoot(bullet, direction, position, shootSpeed):
	add_child(bullet)
	bullet.start(position, direction, shootSpeed)


func _on_Player_shoot(BulletPlayer, position, direction, shootSpeed):
	print("Le joueur tire")
	add_child(BulletPlayer)
	BulletPlayer.start(position, direction, shootSpeed)
	BulletPlayer.isBulletFromPlayer = true

func _on_Enemy_enemyDie(position,mortExplosion):
	add_child(mortExplosion)
	mortExplosion.position=position
	mortExplosion.emit()
