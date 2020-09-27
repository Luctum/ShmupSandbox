extends Node2D
export (PackedScene) var Enemy1
#ressources pour les musiques
var rng = RandomNumberGenerator.new()

func _ready():
	#gestionnaire de musiques :
	rng.randomize()
	var musiqueAleatoire
	musiqueAleatoire = rng.randf_range(1, 4)
	
func _on_Enemy_shoot(bullet, direction, position, shootSpeed):
	add_child(bullet)
	bullet.start(position, direction, shootSpeed)

func _on_Player_shoot(BulletPlayer, position, direction, shootSpeed):
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
	
func _on_Enemy_enemyDie(position,mortExplosion):
	add_child(mortExplosion)
	mortExplosion.position=position
	mortExplosion.emit()
	playVoiceSoundSometimes()
	$ExplosionSound1.play()

func playVoiceSoundSometimes():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var shouldPlayVoiceSound = rng.randi_range(1,10)
	if(shouldPlayVoiceSound == 1):
		$VoiceSound.play()
