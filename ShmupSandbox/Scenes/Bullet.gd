extends Node2D

export var x = 0
export var y = 4

func _process(delta):
	self.position += Vector2(x, y)
