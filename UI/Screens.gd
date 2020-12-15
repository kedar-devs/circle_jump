extends Node
signal start_game
var current_screen=null
var sound_button={true:preload("res://assets/images/buttons/audioOn.png"),false:preload("res://assets/images/buttons/audioOff.png")}
var music_button={true:preload("res://assets/images/buttons/musicOn.png"),false:preload("res://assets/images/buttons/musicOff.png")}
func _ready():
	register_buttons()
	change_screen($TittleScreen)
func register_buttons():
	var buttons=get_tree().get_nodes_in_group("buttons")
	for button in buttons:
		button.connect("pressed",self,"_on_button_pressed",[button])
func _on_button_pressed(button):
	if Settings.enable_sound:
		$Click.play()
	match button.name:
		"Home":
			 change_screen($TittleScreen)
		"Play":
			change_screen(null)
			yield(get_tree().create_timer(0.5),"timeout")
			emit_signal("start_game")
		"Settings":
			change_screen($SettingScreen)
		"Return":
			change_screen($TittleScreen)
		"Sound":
			Settings.enable_sound=!Settings.enable_sound
			button.texture_normal=sound_button[Settings.enable_sound]
		"Music":
			Settings.enable_music=!Settings.enable_music
			button.texture_normal=music_button[Settings.enable_music]
	
func change_screen(new_screen):
	if current_screen:
		current_screen.disappear()
		yield(current_screen.tween,"tween_completed")
	current_screen=new_screen
	if new_screen:
		current_screen.appear()
		yield(current_screen.tween,"tween_completed")
func game_over(score,highscore):
	var score_box=$GameOverScreen/MarginContainer/VBoxContainer/Scores
	score_box.get_node("Score").text="Score: %s"% score
	score_box.get_node("Best").text="Best: %s"% highscore
	change_screen($GameOverScreen)
	
