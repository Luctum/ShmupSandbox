extends Node2D
export (float) var VolumeUser
var Main = preload("res://Scenes/Main.tscn")
var popupMusiqueScene = load ("res://Scenes/PopupMusique/PopupMusique.tscn")
var popup= null
var can_change_key = false
var action_string
enum ACTIONS {ui_shoot, ui_bomb, ui_focus}

func _ready():
	$AudioStreamPlayer.playing=true
	#var versionActuelleTexte = $CenterContainer/MainMenu/HBoxContainer/VBoxContainer/Version.get_text()
#	if popup==null:
#		popup = popupMusiqueScene.instance()
#		.popup_centered()

	#Définition des touches dans les options
	set_keys() 

#Définit les touches a changer
func set_keys():
	for j in ACTIONS:
		get_node("MainMenu/HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxCont_" + str(j) + "/Button").set_pressed(false)
		if !InputMap.get_action_list(j).empty():
			get_node("MainMenu/HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxCont_" + str(j) + "/Button").set_text(InputMap.get_action_list(j)[0].as_text())
		else:
			get_node("MainMenu/HBoxContainer/Panel/MarginContainer/VBoxContainer/HBoxCont_" + str(j) + "/Button").set_text("Aucun bouton défini !")



func _on_Musique_pressed():
	if($AudioStreamPlayer.stream_paused==false):
		$AudioStreamPlayer.stream_paused=true
		$MainMenu/HBoxContainer/VBoxContainer/MenuOptions/HBoxContainer2/SliderVolume.editable=false
	else:
		$AudioStreamPlayer.stream_paused=false
		$MainMenu/HBoxContainer/VBoxContainer/MenuOptions/HBoxContainer2/SliderVolume.editable=true



func _on_SliderVolume_value_changed(value):
	print("Volume défini à ", value)
	VolumeUser=$AudioStreamPlayer.set_volume_db(value-25)

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
func _change_key(new_key):
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




func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen




func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.playing=true


func _on_NouvellePartie_pressed():
	get_tree().change_scene_to(Main)


func _on_ButtonQuit_pressed():
	get_tree().quit()


func _on_MappingTouches_toggled(button_pressed):
	$MainMenu/HBoxContainer/Panel.popup(0,0,0,0)
