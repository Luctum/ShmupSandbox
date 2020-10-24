extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Popup.show()
	print("Ready")
	list_files_in_directory("res://Assets/music/placeholderMusic/")

func list_files_in_directory(path):
	print("rentre dans la fonction")
	var filesmusic = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			print("Fin de boucle")
			break
		elif not file.begins_with("."):
			print("Boucle")
			filesmusic.append(file)

	dir.list_dir_end()

	$AudioStreamPlayer.set_stream(filesmusic[0])
	print("Fin de fonction").filesmusic[1]
	return filesmusic

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
