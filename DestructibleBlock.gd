tool

extends KinematicBody2D

signal destroyed

const TERMINAL_VELOCITY = 500.0
var velocity := Vector2(0,0)
var gravity := 500.0 * 60.0
var gravity_active = false

func _physics_process(delta):
	if gravity_active:
		#velocity.y = min(velocity.y + (gravity*delta), TERMINAL_VELOCITY)
		velocity.y = lerp(velocity.y, TERMINAL_VELOCITY, delta)
		var collision = move_and_collide(velocity*delta)

func dislodge():
	$Timer.start()

func start_fall():
	gravity_active = true
	collision_layer = 0
	collision_mask = 0

func destroy():
	emit_signal("destroyed")
	queue_free()

func hit_paddle(body):
	print("Paddle Hit")
	get_tree().call_group("game", "paddle_hit")
