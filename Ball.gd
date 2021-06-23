extends KinematicBody2D
class_name Ball

var active = true
var velocity := Vector2(0,0)
var direction := Vector2.ZERO
var rng = RandomNumberGenerator.new()

export (int) var speed := 360

func _ready():
	rng.randomize()
	var init_dir = deg2rad(rng.randf_range(-135.0, -45.0))
	direction = Vector2(cos(init_dir), sin(init_dir))


func _physics_process(delta):
	if active:
		velocity = direction * speed
		var collision = move_and_collide(velocity * delta, true, true, true)
		if collision:
			if collision.collider.has_method("get_bounce_direction"):
				direction = collision.collider.get_bounce_direction(collision.position)
			else:
				direction = velocity.bounce(collision.normal).normalized()
			
			if collision.collider.has_method("dislodge"):
				collision.collider.dislodge()
		else:
			move_and_collide(velocity * delta)

func fade_out_and_destroy():
	collision_layer = 0
	#collision_mask = 0
	Globals.fade_out_and_destroy(self, 1.5)

func destroy(object, key):
	queue_free()
