extends Node2D
export (PackedScene) var Enemy1
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



func _on_EnemySpawnTimer_timeout():
	$EnemySpawnZone/PathFollow2D.offset = randi()
	var enemy = Enemy1.instance()
	add_child(enemy)
	enemy.position=$EnemySpawnZone/PathFollow2D.position+$EnemySpawnZone.position
	enemy.movementDirection = Vector2(0,1)
	print(enemy.position)
	
