extends Node2D

var blocks_scene = preload("res://Blocks.tscn")
var ball_scene = preload("res://Ball.tscn")
var paddle_scene = preload("res://Paddle.tscn")
var ball = null
var paddle = null

var game_over := false
var round_starting := false

func _process(delta):
	if not game_over and not round_starting:
		if round_over():
			new_round()
#	if Input.is_action_just_pressed("reset"):
#		new_round()

func _ready():
	Globals.play_game_music()
	#new_round()
	start_game()

func start_game():
	Globals.reset_stats()
	Globals.increment_round()
	set_blocks()
	set_ball_and_paddle()
	$UICanvasLayer.start_screen()

func new_round():
	round_starting = true
	$NewRoundTimer.start()
	Globals.increment_round()
	clear_game()

func set_up_new_round():
	clear_blocks()
	set_blocks()
	set_ball_and_paddle()
	$UICanvasLayer.continue_screen()
	round_starting = false

func restart():
	new_round()

func end_game():
	if not game_over:
		game_over = true
		clear_game()
		$UICanvasLayer.results_screen()

func set_blocks():
	$BlocksSpawn.modulate.a = 0.0
	Globals.fade_in($BlocksSpawn, 2.0)
	var blocks = blocks_scene.instance()
	$BlocksSpawn.call_deferred("add_child", blocks)

func set_ball_and_paddle():
	ball = ball_scene.instance()
	ball.modulate.a = 0.0
	add_child(ball)
	ball.position = $BallSpawn.position
	
	paddle = paddle_scene.instance()
	paddle.modulate.a = 0.0
	add_child(paddle)
	paddle.position = $PaddleSpawn.position
	
	Globals.fade_in(ball, 2.0)
	Globals.fade_in(paddle, 2.0)

func _on_LoseArea_body_entered(body):
	if body is Block:
		body.queue_free()
	elif body is Ball:
		clear_ball()
		end_game()

func _on_Blocks_all_blocks_destroyed():
	new_round()

func clear_game():
	#clear_blocks()
	fade_out_blocks()
	clear_ball()
	clear_paddle()

func clear_blocks():
	for node in $BlocksSpawn.get_children():
		node.queue_free()

func fade_out_blocks():
	for blocks in $BlocksSpawn.get_children():
		for block in blocks.get_children():
			block.fade_out_and_destroy()

func clear_ball():
	if is_instance_valid(ball):
		#ball.queue_free()
		ball.fade_out_and_destroy()

func clear_paddle():
	if is_instance_valid(paddle):
		#paddle.queue_free()
		paddle.fade_out_and_destroy()

func paddle_hit():
	new_round()

func _play_music():
	Globals.play_game_music()

func round_over():
	return get_tree().get_nodes_in_group('block').size() == 0
