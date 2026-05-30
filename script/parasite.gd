class_name Parasite
extends Node

@onready var field : Map = %Map

signal parasite_dead

# le colza ne doit pas être mort ni cut
@export var spreadRules = {
	"waterLevel":1,
	"sunLevel":2,
	"soilLevel":2 #unused pour l'instant
}

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
	current_cell.KillColza()
	#duplicate into adjacent_cell
	var target = _get_target_cell()
	if not target:
		push_error("No valid cells for spreading, game won!")
		parasite_dead.emit()
		return
	(target as Cell).set_state(Cell.CellState.containParasite)
	current_cell = target

func end_turn():
	pass


func _on_game_manager_init_game() -> void:
	_spawn_parasite()

func _get_target_cell() -> Variant:
	#get adjacent cells to current_cell
	var adjacent_cells = field.getAdjacentCellsTo(current_cell)
	print("\ncandidate_cells:\n")
	for c : Cell in adjacent_cells:
		print("name: {0},soilLevel: {1},sunLevel: {2},waterLevel: {3},state: {4}\n".format([c.name, c.soilLevel, c.sunLevel, c.waterLevel, c.state]))
	#filter to keep good ones
	var valid_cells = adjacent_cells.filter(func(c : Cell):
		return c.waterLevel == spreadRules["waterLevel"] && c.sunLevel == spreadRules["sunLevel"] && c.state == Cell.CellState.containColza  )
	print("\nvalid_cells:\n")
	for c : Cell in valid_cells:
		print("name: {0},soilLevel: {1},sunLevel: {2},waterLevel: {3},state: {4}\n".format([c.name, c.soilLevel, c.sunLevel, c.waterLevel, c.state]))
	#random select between good ones
	if len(valid_cells) == 0:
		return null
	return valid_cells.pick_random()
