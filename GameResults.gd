extends Control

var active := false

func _ready():
	$RestartButton.disabled = true
	$QuitButon.disabled = true
	modulate.a = 0.0

func fade_results_in():
	active = true
	$RestartButton.disabled = false
	$QuitButon.disabled = false
	$RoundsNumber.bbcode_text = "[right]" + str(Globals.current_round) + "[/right]"
	$BlocksNumber.bbcode_text = "[right]" + str(Globals.blocks_knocked) + "[/right]"
	$Tween.interpolate_property(self, "modulate", modulate, Color(modulate.r, modulate.g, modulate.b, 1.0), 2.0)
	$Tween.start()

#func fade_results_out():
#	active = false
#	$RestartButton.disabled = true
#	$QuitButon.disabled = true
#	$Tween.interpolate_property(self, "modulate", modulate, Color(modulate.r, modulate.g, modulate.b, 0.0), 2.0)
#	$Tween.start()
