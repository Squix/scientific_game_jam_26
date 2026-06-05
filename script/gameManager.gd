extends Node

enum state {PlayerTurn, ParasiteTurn, GameOver}

signal init_game
signal start_parasite_turn
signal start_player_turn
signal game_won(score: int)
signal game_lost(score: int)
signal score_updated(new_score:int)
signal reset_game

@onready var map := %Map

@export var HEALTHY_FIELD_THRESHOLD = 0.5

var currentState: state = state.PlayerTurn
var score : int

func _update_score() -> int:
	score = len(map.getAliveCells())
	score_updated.emit(score)
	return score

func _init_game():
	
	score = map.width * map.height
	score_updated.emit(score)
	init_game.emit()
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
	var last_score = _update_score()
	game_won.emit(last_score)


func _on_parasite_parasite_turn_ended() -> void:
	#check if colza field is still healthy
	if len(map.getAliveCells()) < (map.width * map.height)*HEALTHY_FIELD_THRESHOLD:
		print("GAME OVER - you LOST")
		_update_score()
		game_lost.emit(score)
	EndParasiteTurn()


func _on_player_parasite_cut() -> void:
	var last_score = _update_score()
	game_won.emit(last_score)


func _on_player_colza_cut() -> void:
	_update_score()


func _on_parasite_parasite_cut_colza() -> void:
	_update_score()


func _on_ui_restart_button_pressed() -> void:
	reset_game.emit()
	_init_game()
