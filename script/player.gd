class_name Player
extends Node

enum tool {none,watteringCan,magnifyingGlass,scythe,tree}

signal no_actions_left

@onready var map : Map = %Map

const actionPerPhase = 1
var remainingAction = 0

var currentTool : Player.tool =  Player.tool.none

func start_turn():
	print_debug("Start Player Turn")
	remainingAction = actionPerPhase

func end_turn():
	pass


func useWatteringCanAt(_cell:Cell):
	_cell.updateWaterLevel(1)

func useMagnifyingGlassAt(cell:Cell):
	cell.open_colza()

func useTreeAt(_cell:Cell):
	pass

func useScytheAt(_cell:Cell):
	_cell.CutColza()

func _on_ui_new_tool_selected(newTool: Player.tool) -> void:
	currentTool = newTool
	print(currentTool)
	pass # Replace with function body.


func _on_ui_next_turn_pressed() -> void:
	end_turn()
	pass # Replace with function body.


func _on_player_input_map_clicked(_worldPosition: Vector3) -> void:
	if(remainingAction <= 0):
		return
	
	var coord = %Map.worldPosToCellCoord(_worldPosition)
	var cell : Cell = %Map.getCellSafe(coord.x,coord.y)
	
	if(!cell):
		return
	
	
	match currentTool:
		Player.tool.none:
			return
		Player.tool.scythe:
			useScytheAt(cell)
		Player.tool.watteringCan:
			useWatteringCanAt(cell)
		Player.tool.magnifyingGlass:
			useMagnifyingGlassAt(cell)
		Player.tool.tree:
			useTreeAt(cell)
	
	remainingAction -= 1
	if(remainingAction <= 0):
		no_actions_left.emit()
