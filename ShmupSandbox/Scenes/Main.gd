extends Node2D

func _on_Enemy_shoot(bullet, direction, position, shootSpeed):
	add_child(bullet)
	bullet.start(position, direction, shootSpeed)

func _on_Player_shoot(BulletPlayer, position, direction, shootSpeed):
	add_child(BulletPlayer)
	BulletPlayer.start(position, direction, shootSpeed)
	BulletPlayer.isBulletFromPlayer = true

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
