extends Node2D

#ressources pour les musiques
var rng = RandomNumberGenerator.new()
var musiqueJouee = load("res://Assets/music/placeholderMusic/electric-dragon-legion-black.wav")

func _ready():
	#gestionnaire de musiques :
	rng.randomize()
	var musiqueAleatoire
	musiqueAleatoire = rng.randf_range(1, 4)
	if(musiqueAleatoire>=2):
		$AudioStreamPlayer.set_stream(musiqueJouee)
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
