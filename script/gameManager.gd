extends Node

enum state {PlayerTurn, ParasiteTurn, GameOver}

signal init_game
signal start_parasite_turn
signal start_player_turn
signal game_won()
signal game_lost()

@onready var map := %Map

@export var HEALTHY_FIELD_THRESHOLD = 0.5

var currentState: state = state.PlayerTurn

func _ready() -> void:
	init_game.emit()
	StartPlayerTurn()

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
