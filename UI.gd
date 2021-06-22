extends Control

signal restart

func _ready():
	$GameResults.modulate.a = 0.0

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			_unpause()
		else:
			_pause()
	if Input.is_action_just_pressed("start"):
		_unpause()

func _pause():
	get_tree().paused = true
	$PauseScreen.visible = not $StartPrompt.visible

func _unpause():
	get_tree().paused = false
	for prompt in get_children():
		prompt.visible = false

func start_screen():
	$StartPrompt.visible = true
	_pause()


func _on_ContinueButton_pressed():
	_unpause()


func _on_RestartButton_pressed():
	get_tree().change_scene("res://Game.tscn")


func _on_QuitButon_pressed():
	Globals.stop_music()
	get_tree().change_scene("res://MainMenu.tscn")

func fade_results_in():
	print("called")
	$GameResults.visible = true
#	$GameResults/RoundsNumber.bbcode_text = "[right]" + str(Globals.current_round) + "[/right]"
#	$GameResults/BlocksNumber.bbcode_text = "[right]" + str(Globals.blocks_knocked) + "[/right]"
	$GameResults/Tween.interpolate_property($GameResults, "modulate", $GameResults.modulate, Color(modulate.r, modulate.g, modulate.b, 255.0), 2.0)
	$GameResults/Tween.start()

func fade_results_out():
	$GameResults/Tween.interpolate_property($GameResults, "modulate", $GameResults.modulate, Color(modulate.r, modulate.g, modulate.b, 0.0), 2.0)
	$GameResults/Tween.start()
