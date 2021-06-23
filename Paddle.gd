extends KinematicBody2D
class_name Player

export (int) var speed := 360
var velocity := Vector2(0,0)
var active := true
var extents = Vector2(41.0, 10.0)

func _ready():
	pass

func _process(delta):
	pass
	
func _physics_process(delta):
	if active:
		if Input.is_action_pressed("right"):
			velocity.x = speed
		elif Input.is_action_pressed("left"):
			velocity.x = -speed
		
		# might need to add logicn to make sure the paddle doesn't stop moving when
		# the ball hits it. Move and collide might end up ding that automatically.
		var collision = move_and_collide(velocity * delta)
		velocity.x = lerp(velocity.x, 0, .2)

func get_bounce_direction(collision_position):
	var collision_x = collision_position.x
	var paddle_x = global_position.x
	var relative_collision_x = collision_x - paddle_x - extents.x
	var direction_in_degrees = (relative_collision_x) / (extents.x * 2.0) * (90.0) - (45.0)
	var direction_in_rads = deg2rad(direction_in_degrees)
	return Vector2(cos(direction_in_rads), sin(direction_in_rads))

func fade_out_and_destroy():
	collision_layer = 0
	collision_mask = 0
	Globals.fade_out_and_destroy(self, 1.5)
