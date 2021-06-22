extends Control

func _ready():
	get_tree().paused = false

func _on_CollideWithBall_toggled(button_pressed):
	Globals.collides_with_ball_while_falling = button_pressed


func _on_CollideWithPaddle_toggled(button_pressed):
	Globals.collides_with_player = button_pressed


func _on_FallSlowly_toggled(button_pressed):
	Globals.falls_slowly = button_pressed


func _on_StartButton_pressed():
	Globals.stop_music()
	get_tree().change_scene("res://Game.tscn")


func _on_SettingsButton_pressed():
	get_tree().change_scene("res://SettingMenu.tscn")

func _play_music():
	Globals.play_menu_music()
