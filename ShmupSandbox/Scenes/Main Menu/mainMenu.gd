extends Node2D
export (float) var VolumeUser
var Main = preload("res://Scenes/Main.tscn")
var popupMusiqueScene = load ("res://Scenes/PopupMusique/PopupMusique.tscn")
var popup= null
var can_change_key = false
var action_string
enum ACTIONS {ui_shoot, ui_bomb, ui_focus}
var positionTitre
var positionTitreOld
var isAdding = false

func _ready():
	$AudioAnnoncer.playing=true
	#var versionActuelleTexte = $CenterContainer/MainMenu/HBoxContainer/VBoxContainer/Version.get_text()
#	if popup==null:
#		popup = popupMusiqueScene.instance()
#		.popup_centered()

	#Définition des touches dans les options
	set_keys() 

func _on_AudioAnnoncer_finished():
	$AudioStreamPlayer.playing=true
#-------------------------------------------------------------------------------------
#EDITER LES TOUCHES
#Définit les touches a changer
func set_keys():
	for j in ACTIONS:
		get_node("MainMenu/HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxCont_" + str(j) + "/Button").set_pressed(false)
		if !InputMap.get_action_list(j).empty():
			get_node("MainMenu/HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxCont_" + str(j) + "/Button").set_text(InputMap.get_action_list(j)[0].as_text())
			print("InputMap")
		else:
			get_node("MainMenu/HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxCont_" + str(j) + "/Button").set_text("Aucun bouton défini !")


func b_change_key_SHOOT():
	_mark_button("ui_shoot")

func b_change_key_BOMB():
	_mark_button("ui_bomb")

func b_change_key_FOCUS():
	_mark_button("ui_focus")


func _on_Musique_pressed():
	$AudioSoundsMenu.playing=true
	if($AudioStreamPlayer.stream_paused==false):
		$AudioStreamPlayer.stream_paused=true
		$MainMenu/HBoxContainer/VBoxContainer/MenuOptions/HBoxContainer2/SliderVolume.editable=false
	else:
		$AudioStreamPlayer.stream_paused=false
		$MainMenu/HBoxContainer/VBoxContainer/MenuOptions/HBoxContainer2/SliderVolume.editable=true



func _on_SliderVolume_value_changed(value):
	$AudioSoundsMenu.playing=true
	print("Volume défini à ", value)
	VolumeUser=$AudioStreamPlayer.set_volume_db(value)

#Signal Bouton tirer (OPTIONS)
func b_change_key_ui_shoot():
	_mark_button("ui_shoot")
#Signal Bouton bombes (OPTIONS)
func b_change_key_ui_bomb():
	_mark_button("ui_bomb")
#Signal Bouton focus (OPTIONS)
func b_change_key_ui_focus():
	_mark_button("ui_focus")


#Fonctions pour définir les touches dans les options :
func _mark_button(string):
	can_change_key = true
	action_string = string
	
	for j in ACTIONS:
		if j != string:
			get_node("MainMenu/HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxCont_" + str(j) + "/Button").set_pressed(false)

func _input(event):
	if event is InputEventKey: 
		if can_change_key:
			_change_key(event)
			can_change_key = false
			print("_input(event)")

func _change_key(new_key):
	print("_change_key")
	#Supprime la touche du bouton choisi
	if !InputMap.get_action_list(action_string).empty():
		InputMap.action_erase_event(action_string, InputMap.get_action_list(action_string)[0])
	
	#Vérifie que la touche n'est pas déjà attribuée
	for i in ACTIONS:
		if InputMap.action_has_event(i, new_key):
			InputMap.action_erase_event(i, new_key)
			
	#Ajoute la nouvelle touche
	InputMap.action_add_event(action_string, new_key)
	
	set_keys()

func _process(delta):
	positionTitreOld=positionTitre
	positionTitre=$MainMenu/HBoxContainer/Path2D/PathFollow2D.get_offset()
	if (isAdding==false):
		positionTitre+1
		$MainMenu/HBoxContainer/Path2D/PathFollow2D.set_offset($MainMenu/HBoxContainer/Path2D/PathFollow2D.get_offset()+1)
	else:
		positionTitre-1
		$MainMenu/HBoxContainer/Path2D/PathFollow2D.set_offset($MainMenu/HBoxContainer/Path2D/PathFollow2D.get_offset()-1)
	
	positionTitre=$MainMenu/HBoxContainer/Path2D/PathFollow2D.get_offset()
	if (positionTitre==60 or positionTitre==0):
		isAdding= !isAdding


func _on_Fullscreen_pressed():
	$AudioSoundsMenu.playing=true
	OS.window_fullscreen = !OS.window_fullscreen




func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.playing=true


func _on_NouvellePartie_pressed():
	$AudioSoundsMenu.playing=true
	get_tree().change_scene_to(Main)


func _on_ButtonQuit_pressed():
	$AudioSoundsMenu.playing=true
	get_tree().quit()


func _on_MappingTouches_toggled(button_pressed):
	pass





func _on_MappingTouches_pressed():
	$AudioSoundsMenu.playing=true
	if($MainMenu/HBoxContainer/Panel.visible==false):
		$MainMenu/HBoxContainer/Panel.show()
		print("affiche")
	else:
		$MainMenu/HBoxContainer/Panel.hide()
		print("cache")


