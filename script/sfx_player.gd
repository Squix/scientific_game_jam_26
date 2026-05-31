extends AudioStreamPlayer
class_name SFXplayer

enum SFX {ColzaHover, ToolSelect, ToolScythe}

var colza_hover_stream = preload("res://Assets/sounds/Colza_Hover.mp3")
var tool_select_stream = preload("res://Assets/sounds/Tool_Select.mp3")
var tool_scythe_stream = preload("res://Assets/sounds/Action_Fauchage.mp3")

func play_sfx(sfx_name: SFX):
	stop()
	if sfx_name == SFX.ColzaHover:
		stream = colza_hover_stream
		volume_db = -8.0
	elif sfx_name == SFX.ToolSelect:
		stream = tool_select_stream
		volume_db = -16.0
	elif sfx_name == SFX.ToolScythe:
		stream = tool_scythe_stream
		volume_db = -16.0
	pitch_scale = randf_range(0.7,1.35)
	play()
