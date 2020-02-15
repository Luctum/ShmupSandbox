extends Light2D
var red
var green
var blue

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	red = randf()
	green = randf()
	blue = randf()
	print(red)
	self.color = Color(red,green,blue)
#	pass
