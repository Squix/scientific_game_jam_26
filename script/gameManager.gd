extends Node

enum state {PlayerTurn, ParasiteTurn, GameOver}

signal init_game
signal start_parasite_turn
signal start_player_turn
signal game_won()
signal game_lost()

const actionPerPhase = 1
var remainingAction = 0
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

func onActionTaken():
	remainingAction -= 1
	if(remainingAction <= 0):
		EndPlayerTurn()
		pass

func onMapClicked(_worldPosition:Vector3):
	var coord = %Map.worldPosToCellCoord(_worldPosition)
	var cell : Cell = %Map.getCellSafe(coord.x,coord.y)
	if(cell):
		cell.CutColza()
	onActionTaken()

func StartParasiteTurn():
	currentState = state.ParasiteTurn
	start_parasite_turn.emit()
	EndParasiteTurn()

func EndParasiteTurn():
	advanceState()
	pass

func _on_ui_next_turn_pressed() -> void:
	EndPlayerTurn()
	pass # Replace with function body.


func _on_parasite_parasite_dead() -> void:
	game_won.emit()
