extends Node

enum state {PlayerTurn, ParasiteTurn, GameOver}

const actionPerPhase = 1
var remainingAction = 0
var currentState: state = state.PlayerTurn

func _ready() -> void:
	StartPlayerTurn()

func advanceState():
	#check for game end
	match currentState:
		state.PlayerTurn:
			StartParasiteTurn()
		state.ParasiteTurn:
			StartPlayerTurn()

func StartPlayerTurn():
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
		cell.KillColza()
	onActionTaken()

func StartParasiteTurn():
	currentState = state.ParasiteTurn
	print_debug("Start Parasite Turn")
	EndParasiteTurn()
	pass

func EndParasiteTurn():
	advanceState()
	pass
