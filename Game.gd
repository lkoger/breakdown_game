extends Node2D

var blocks_scene = preload("res://Blocks.tscn")
var ball_scene = preload("res://Ball.tscn")
var paddle_scene = preload("res://Paddle.tscn")
var ball = null
var paddle = null

func _process(delta):
	if Input.is_action_just_pressed("reset"):
		new_round()

func _ready():
	new_round()

func new_round():
	clear_game()
	var blocks = blocks_scene.instance()
	$BlocksSpawn.call_deferred("add_child", blocks)
	set_ball_and_paddle()
	$UI.start_screen()

func restart():
	new_round()

func end_game():
	new_round()

func set_ball_and_paddle():
	ball = ball_scene.instance()
	add_child(ball)
	ball.position = $BallSpawn.position
	
	paddle = paddle_scene.instance()
	add_child(paddle)
	paddle.position = $PaddleSpawn.position

func _on_LoseArea_body_entered(body):
	end_game()


func _on_Blocks_all_blocks_destroyed():
	print("All blocks destroyed")
	new_round()

func clear_game():
	for node in $BlocksSpawn.get_children():
		node.queue_free()
	if is_instance_valid(ball):
		ball.queue_free()
	if is_instance_valid(paddle):
		paddle.queue_free()

func paddle_hit():
	new_round()
