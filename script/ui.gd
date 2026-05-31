class_name UI

extends Node

@onready var gameWonUI := $GameWon
@onready var gameLostUI := $GameLost
@onready var nextTurnButton := $CenterContainer/MarginContainer/NextTurn
@onready var toolsUI := $Tools
@onready var watteringCanIcon : TextureButton = toolsUI.get_node("HBoxContainer/WatteringCan")
@onready var scoreLabel := $ScoreLabel

@onready var sfxPlayer = $"../SFXplayer"

signal newToolSelected(newTool:  Player.tool)
signal nextTurnPressed()
signal restartButtonPressed()

func _on_wattering_can_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		newToolSelected.emit( Player.tool.watteringCan)

func _on_magnifying_glass_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		newToolSelected.emit( Player.tool.magnifyingGlass)

func _on_tree_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		newToolSelected.emit( Player.tool.tree)

func _on_scythe_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		newToolSelected.emit( Player.tool.scythe)

func _on_next_turn_pressed() -> void:
	sfxPlayer.play_sfx(SFXplayer.SFX.ButtonClick)
	await get_tree().create_timer(1).timeout
	nextTurnPressed.emit()


func _on_game_game_won() -> void:
	gameWonUI.show()
	toolsUI.hide()
	nextTurnButton.hide()


func _on_game_game_lost() -> void:
	gameLostUI.show()
	toolsUI.hide()
	nextTurnButton.hide()


func _on_game_init_game() -> void:
	gameLostUI.hide()
	gameWonUI.hide()
	toolsUI.show() 
	nextTurnButton.show()


func _on_player_no_actions_left() -> void:
	toolsUI.hide()


func _on_game_start_player_turn() -> void:
	var pressedButton = $Tools/HBoxContainer/WatteringCan.button_group.get_pressed_button()
	if(pressedButton):
		pressedButton.set_pressed_no_signal(false)
	toolsUI.show()


func _on_game_score_updated(new_score: int) -> void:
	scoreLabel.text = "Remaining colza: {0}".format([new_score])


func _on_restart_button_pressed() -> void:
	sfxPlayer.play_sfx(SFXplayer.SFX.ButtonClick)
	restartButtonPressed.emit()
