extends Control

signal restart

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			_unpause()
		else:
			_pause()
	if Input.is_action_just_pressed("start"):
		_unpause()

func _pause():
	get_tree().paused = true

func _unpause():
	get_tree().paused = false
	for prompt in get_children():
		prompt.visible = false

func start_screen():
	$StartPrompt.visible = true
	_pause()
