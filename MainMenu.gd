extends Control


func _ready():
	$CollideWithBall.pressed = Globals.collides_with_ball_while_falling
	$CollideWithPaddle.pressed = Globals.collides_with_player
	$FallSlowly.pressed = Globals.falls_slowly
	


func _on_CollideWithBall_toggled(button_pressed):
	Globals.collides_with_ball_while_falling = button_pressed


func _on_CollideWithPaddle_toggled(button_pressed):
	Globals.collides_with_player = button_pressed


func _on_FallSlowly_toggled(button_pressed):
	Globals.falls_slowly = button_pressed


func _on_Button_pressed():
	get_tree().change_scene("res://Game.tscn")
