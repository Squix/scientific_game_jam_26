class_name UI

extends Node

enum tool {none,watteringCan,magnifyingGlass,tree}
var currentTool: tool = tool.none

signal newToolSelected(newTool: tool)
signal nextTurnPressed()

func _on_wattering_can_toggled(toggled_on: bool) -> void:
	if(toggled_on and not currentTool == tool.watteringCan):
		currentTool = tool.watteringCan
		newToolSelected.emit(tool.watteringCan)

func _on_magnifying_glass_toggled(toggled_on: bool) -> void:
	if(toggled_on and not currentTool == tool.magnifyingGlass):
		currentTool = tool.magnifyingGlass
		newToolSelected.emit(tool.magnifyingGlass)


func _on_tree_toggled(toggled_on: bool) -> void:
	if(toggled_on and not currentTool == tool.tree):
		currentTool = tool.tree
		newToolSelected.emit(tool.tree)

func _on_next_turn_pressed() -> void:
	nextTurnPressed.emit()
