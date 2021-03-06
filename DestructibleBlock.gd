tool

extends KinematicBody2D
class_name Block

signal destroyed

export(Texture) var block_texture

const TERMINAL_VELOCITY = 500.0
var velocity := Vector2(0,0)
var gravity := 500.0
var gravity_active = false
var dislodged = false
onready var collides_with_ball_while_falling = Globals.collides_with_ball_while_falling
onready var falls_slowly = Globals.falls_slowly
onready var collides_with_player = Globals.collides_with_player

func _ready():
	$Sprite.texture = block_texture

func _physics_process(delta):
	if gravity_active:
		if falls_slowly:
			velocity.y = lerp(velocity.y, TERMINAL_VELOCITY/8.0, delta)
		else:
			velocity.y = lerp(velocity.y, TERMINAL_VELOCITY, delta)
		var collision = move_and_collide(velocity*delta)

func dislodge():
	if not dislodged:
		Globals.increment_blocks_knocked()
		$Timer.start()
		$AnimationPlayer.play("shake")
		dislodged = true

func start_fall():
	gravity_active = true
	set_collision_layer_bit(3, collides_with_ball_while_falling)
	$Area2D.set_collision_mask_bit(2, collides_with_player)
	

func destroy():
	emit_signal("destroyed")
	queue_free()


func _on_Area2D_body_entered(body):
	if body is Player:
		body.shake()
		get_tree().get_nodes_in_group("game")[0].end_game()

func fade_out_and_destroy():
	#collision_layer = 0
	#collision_mask = 0
#	$Area2D.collision_layer = 0
#	$Area2D.collision_mask = 0
	Globals.fade_out_and_destroy(self, 1.5)
