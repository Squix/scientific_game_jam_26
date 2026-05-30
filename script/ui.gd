class_name UI

extends Node

signal newToolSelected(newTool:  Player.tool)
signal nextTurnPressed()

func _on_wattering_can_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		newToolSelected.emit( Player.tool.watteringCan)

func _on_magnifying_glass_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		newToolSelected.emit( Player.tool.magnifyingGlass)

func _on_tree_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		newToolSelected.emit( Player.tool.tree)

func _on_next_turn_pressed() -> void:
	nextTurnPressed.emit()
