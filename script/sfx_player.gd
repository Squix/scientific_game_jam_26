extends AudioStreamPlayer
class_name SFXplayer

enum SFX {ColzaHover}

var colza_hover_stream = preload("res://Assets/sounds/Colza_Hover.mp3")

func play_sfx(sfx_name: SFX):
	stop()
	if sfx_name == SFX.ColzaHover:
		stream = colza_hover_stream
		pitch_scale = randf_range(0.7,1.35)
	play()
