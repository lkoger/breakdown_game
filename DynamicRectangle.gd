tool

extends StaticBody2D

export (Vector2) var extents = Vector2.ZERO

func _ready():
	var collision_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = extents
	collision_shape.shape = shape
	add_child(collision_shape)

func _process(delta):
	update()

func _draw():
	var rect = Rect2(-extents, extents * 2.0)
	draw_rect(rect, Color.black)
