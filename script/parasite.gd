class_name Parasite
extends Node

@onready var field : Map = %Map

func _spawn_parasite():
	#get field
	#get a random cell
	#change state of this random cell
	var random_cell : Cell = field.getCellUnsafe(randi_range(0, field.width), randi_range(0, field.height))
	random_cell.set_state(Cell.CellState.containParasite)
func start_turn():
	pass

func end_turn():
	pass


func _on_game_manager_init_game() -> void:
	_spawn_parasite()
