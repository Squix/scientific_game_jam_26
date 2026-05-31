extends Control

@onready var titleUI = $PanelContainer/CenterContainer/Title
@onready var howToPlayUI = $PanelContainer/CenterContainer/HowToPlay
@onready var sfxPLayer = $SFXplayer

func _ready():
	titleUI.show()
	howToPlayUI.hide()
	


func _on_see_how_to_pressed() -> void:
	sfxPLayer.play()
	howToPlayUI.show()
	titleUI.hide()


func _on_start_game_pressed() -> void:
	sfxPLayer.play()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
