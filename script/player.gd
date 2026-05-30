class_name Player
extends Node

enum tool {none,watteringCan,magnifyingGlass,scythe,tree}


@onready var map : Map = %Map

const actionPerPhase = 1
var remainingAction = 0

var currentTool : Player.tool =  Player.tool.none

func start_turn():
	print_debug("Start Player Turn")
	%PlayerInput.connect("map_clicked",onMapClicked)
	remainingAction = actionPerPhase

func end_turn():
	%PlayerInput.disconnect("map_clicked",onMapClicked)
	pass



func onMapClicked(_worldPosition:Vector3):
	if(remainingAction <= 0):
		return
	
	var coord = %Map.worldPosToCellCoord(_worldPosition)
	var cell : Cell = %Map.getCellSafe(coord.x,coord.y)
	
	if(!cell):
		return
	
	match currentTool:
		Player.tool.none:
			pass
		Player.tool.scythe:
			useScytheAt(cell)
		Player.tool.watteringCan:
			useWatteringCanAt(cell)
		Player.tool.magnifyingGlass:
			useMagnifyingGlassAt(cell)
		Player.tool.tree:
			useTreeAt(cell)
	
	remainingAction -= 1

func useWatteringCanAt(_cell:Cell):
	_cell.updateWaterLevel(1)

func useMagnifyingGlassAt(_cell:Cell):
	pass

func useTreeAt(_cell:Cell):
	pass

func useScytheAt(_cell:Cell):
	_cell.CutColza()

func _on_ui_new_tool_selected(newTool: Player.tool) -> void:
	currentTool = newTool
	pass # Replace with function body.


func _on_ui_next_turn_pressed() -> void:
	end_turn()
	pass # Replace with function body.
