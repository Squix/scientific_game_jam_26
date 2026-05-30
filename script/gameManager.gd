extends Node

enum state {PlayerTurn, ParasiteTurn, GameOver}

signal init_game
signal start_parasite_turn
signal start_player_turn

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
	print_debug("Start Player Turn")
	%PlayerInput.connect("map_clicked",onMapClicked)
	
	remainingAction = actionPerPhase
	pass

func EndPlayerTurn():
	%PlayerInput.disconnect("map_clicked",onMapClicked)
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
