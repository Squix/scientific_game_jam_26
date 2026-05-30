class_name Parasite
extends Node

@onready var field : Map = %Map

var current_cell : Cell

func _spawn_parasite():
	#get field
	#get a random cell
	#change state of this random cell
	var random_cell : Cell = field.getCellUnsafe(randi_range(0, field.width), randi_range(0, field.height))
	random_cell.set_state(Cell.CellState.containParasite)
	current_cell = random_cell
	
func start_turn():
	print("Parasite turn")
	#kill current_cell
	print("current_cell", current_cell)
	current_cell.KillColza()
	pass

func end_turn():
	pass


func _on_game_manager_init_game() -> void:
	_spawn_parasite()
