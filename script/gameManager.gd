extends Node

enum state {PlayerTurn, ParasiteTurn, GameOver}

signal init_game
signal start_parasite_turn
signal start_player_turn
signal game_won()
signal game_lost()
signal score_updated(new_score:int)
signal reset_game

@onready var map := %Map

@export var HEALTHY_FIELD_THRESHOLD = 0.5

var currentState: state = state.PlayerTurn

func _init_game():
	init_game.emit()
	var new_score = map.width * map.height
	score_updated.emit(new_score)
	StartPlayerTurn()

func _ready() -> void:
	_init_game()

func advanceState():
	#check for game end
	match currentState:
		state.PlayerTurn:
			StartParasiteTurn()
		state.ParasiteTurn:
			StartPlayerTurn()

func StartPlayerTurn():
	start_player_turn.emit()
	currentState = state.PlayerTurn
	pass

func EndPlayerTurn():
	advanceState()
	pass


func StartParasiteTurn():
	currentState = state.ParasiteTurn
	start_parasite_turn.emit()

func EndParasiteTurn():
	advanceState()
	pass

func _on_ui_next_turn_pressed() -> void:
	EndPlayerTurn()
	pass # Replace with function body.


func _on_parasite_parasite_dead() -> void:
	game_won.emit()


func _on_parasite_parasite_turn_ended() -> void:
	#check if colza field is still healthy
	if len(map.getAliveCells()) < (map.width * map.height)*HEALTHY_FIELD_THRESHOLD:
		print("GAME OVER - you LOST")
		game_lost.emit()
	EndParasiteTurn()


func _on_player_parasite_cut() -> void:
	game_won.emit()


func _on_player_colza_cut() -> void:
	score_updated.emit(len(map.getAliveCells()))


func _on_parasite_parasite_cut_colza() -> void:
	score_updated.emit(len(map.getAliveCells()))


func _on_ui_restart_button_pressed() -> void:
	reset_game.emit()
	_init_game()
