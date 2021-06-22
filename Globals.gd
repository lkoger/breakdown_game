extends Node

var falls_slowly := false
var collides_with_ball_while_falling := false
var collides_with_player := true

var menu_music: AudioStream = preload("res://assets/music/menu.wav")
var game_music: AudioStream = preload("res://assets/music/game.wav")
var current_stream = null

var blocks_knocked := 0
var current_round := 0
var music_loops := 0

func _ready():
	pass

func play_menu_music():
	if current_stream != menu_music:
		current_stream = menu_music
		$AudioStreamPlayer.set_stream(menu_music)
		$AudioStreamPlayer.play()

func play_game_music():
	if current_stream != game_music:
		current_stream = game_music
		$AudioStreamPlayer.set_stream(game_music)
		$AudioStreamPlayer.play()

func stop_music():
	if $AudioStreamPlayer.playing:
		$AudioStreamPlayer.stop()
		current_stream = null
	
func set_music_volume(val):
	if val == -25:
		$AudioStreamPlayer.volume_db = -100
	else:
		$AudioStreamPlayer.volume_db = val

func increment_music_loops():
	music_loops += 1
func increment_blocks_knocked():
	blocks_knocked += 1
func increment_round():
	current_round += 1

func reset_stats():
	blocks_knocked = 0
	current_round = 0
