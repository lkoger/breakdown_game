extends Node2D

var blocks_scene = preload("res://Blocks.tscn")
var ball_scene = preload("res://Ball.tscn")
var paddle_scene = preload("res://Paddle.tscn")
var ball = null
var paddle = null

func _process(delta):
	if round_over():
		new_round()
#	if Input.is_action_just_pressed("reset"):
#		new_round()

func _ready():
	Globals.play_game_music()
	new_round()

func new_round():
	Globals.increment_round()
	clear_game()
	var blocks = blocks_scene.instance()
	$BlocksSpawn.call_deferred("add_child", blocks)
	set_ball_and_paddle()
	$UICanvasLayer/UI.start_screen()

func restart():
	new_round()

func end_game():
	$UICanvasLayer/UI.fade_results_in()

func set_ball_and_paddle():
	ball = ball_scene.instance()
	add_child(ball)
	ball.position = $BallSpawn.position
	
	paddle = paddle_scene.instance()
	add_child(paddle)
	paddle.position = $PaddleSpawn.position

func _on_LoseArea_body_entered(body):
	if body is Block:
		body.queue_free()
		print("Block freed")
	elif body is Ball:
		clear_ball()
		end_game()

func _on_Blocks_all_blocks_destroyed():
	new_round()

func clear_game():
	clear_blocks()
	clear_ball()
	clear_paddle()

func clear_blocks():
	for node in $BlocksSpawn.get_children():
		node.queue_free()

func clear_ball():
	if is_instance_valid(ball):
		ball.queue_free()

func clear_paddle():
	if is_instance_valid(paddle):
		paddle.queue_free()

func paddle_hit():
	new_round()


func _play_music():
	Globals.play_game_music()

func round_over():
	return get_tree().get_nodes_in_group('block').size() == 0
