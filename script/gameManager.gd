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

func _init_game():
	init_game.emit()
	score = map.width * map.height
	score_updated.emit(score)
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
	game_won.emit(score)


func _on_parasite_parasite_turn_ended() -> void:
	#check if colza field is still healthy
	if len(map.getAliveCells()) < (map.width * map.height)*HEALTHY_FIELD_THRESHOLD:
		print("GAME OVER - you LOST")
		score = len(map.getAliveCells())
		game_lost.emit(score)
	EndParasiteTurn()


func _on_player_parasite_cut() -> void:
	score = len(map.getAliveCells())
	game_won.emit(score)


func _on_player_colza_cut() -> void:
	score = len(map.getAliveCells())
	score_updated.emit(len(map.getAliveCells()))


func _on_parasite_parasite_cut_colza() -> void:
	score = len(map.getAliveCells())
	score_updated.emit(len(map.getAliveCells()))


func _on_ui_restart_button_pressed() -> void:
	reset_game.emit()
	_init_game()
