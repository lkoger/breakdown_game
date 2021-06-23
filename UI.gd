extends CanvasLayer

signal restart

func _ready():
	$Round.modulate.a = 0.0

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			_unpause()
		else:
			_pause()
	if Input.is_action_just_pressed("start"):
		_unpause()

func play_round_animation():
	$Round.bbcode_text = "[center]" + "Round " + str(Globals.current_round) + "[/center]"
	Globals.fade_in_out($Round, 2.0)

func _pause():
	if not $UI/GameResults.visible:
		get_tree().paused = true
		$UI/PauseScreen.visible = not $UI/StartPrompt.visible and not $UI/ContinuePrompt.visible

func _unpause():
	get_tree().paused = false
	$UI/PauseScreen.visible = false
	$UI/StartPrompt.visible = false
	$UI/ContinuePrompt.visible = false

func start_screen():
	$UI/StartPrompt.modulate.a = 0.0
	Globals.fade_in($UI/StartPrompt, 2.0)
	$UI/StartPrompt.visible = true
	_pause()

func continue_screen():
	$UI/ContinuePrompt.modulate.a = 0.0
	Globals.fade_in($UI/ContinuePrompt, 2.0)
	$UI/ContinuePrompt.visible = true
	_pause()

func results_screen():
	$UI/GameResults.visible = true
	$UI/GameResults/RestartButton.disabled = false
	$UI/GameResults/QuitButon.disabled = false
	$UI/GameResults/RoundsNumber.bbcode_text = "[right]" + str(Globals.current_round - 1) + "[/right]"
	$UI/GameResults/BlocksNumber.bbcode_text = "[right]" + str(Globals.blocks_knocked) + "[/right]"
	$UI/GameResults/MusicLoops.bbcode_text = "[right]" + str(Globals.music_loops) + "[/right]"
	Globals.fade_in($UI/GameResults, 2.0)
#	$UI/GameResults/Tween.interpolate_property($UI/GameResults, "modulate", $UI/GameResults.modulate, Color($UI/GameResults.modulate.r, $UI/GameResults.modulate.g, $UI/GameResults.modulate.b, 1.0), 2.0)
#	$UI/GameResults/Tween.start()

func _on_ContinueButton_pressed():
	_unpause()


func _on_RestartButton_pressed():
	get_tree().change_scene("res://Game.tscn")


func _on_QuitButon_pressed():
	Globals.stop_music()
	get_tree().change_scene("res://MainMenu.tscn")
