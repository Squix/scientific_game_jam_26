class_name Parasite
extends Node

@onready var field : Map = %Map

@onready var sfxPlayer = $"../SFXplayer"

signal parasite_dead
signal parasite_turn_ended
signal parasite_cut_colza

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
	#kill this random cell
	#infect adjacent cell
	var random_cell_coords = {"x":randi_range(0, field.width-1), "z":randi_range(0, field.height-1)}
	var random_cell : Cell = field.getCellUnsafe(random_cell_coords.x, random_cell_coords.z)
	random_cell.set_state(Cell.CellState.dead)
	current_cell = random_cell
	var adjacent_cell : Cell = _get_target_cell()
	adjacent_cell.set_state(Cell.CellState.containParasite)
	current_cell = adjacent_cell
	
func start_turn():
	print("Parasite turn")
	#kill current_cell if healthy
	if current_cell.state == Cell.CellState.containParasite && current_cell.waterLevel < 2:
		sfxPlayer.play_sfx(SFXplayer.SFX.ColzaDeath)
		current_cell.KillColza()
		parasite_cut_colza.emit()
	else:
		current_cell.state = Cell.CellState.containColza
	#duplicate into adjacent_cell
	var target = _get_target_cell()
	if not target:
		print("No valid cells for spreading, game won!")
		parasite_dead.emit()
		return
	(target as Cell).set_state(Cell.CellState.containParasite)
	current_cell = target
	end_turn()

func end_turn():
	parasite_turn_ended.emit()

func _get_target_cell() -> Variant:
	#get adjacent cells to current_cell
	var adjacent_cells = field.getAdjacentCellsTo(current_cell)
	#print("\ncandidate_cells:\n")
	#for c : Cell in adjacent_cells:
		#print("name: {0},soilLevel: {1},sunLevel: {2},waterLevel: {3},state: {4}\n".format([c.name, c.soilLevel, c.sunLevel, c.waterLevel, c.state]))
	#filter to keep good ones
	var valid_cells = adjacent_cells.filter(func(c : Cell):
		return c.waterLevel == spreadRules["waterLevel"] && c.sunLevel == spreadRules["sunLevel"] && c.state == Cell.CellState.containColza  )
	#print("\nvalid_cells:\n")
	#for c : Cell in valid_cells:
		#print("name: {0},soilLevel: {1},sunLevel: {2},waterLevel: {3},state: {4}\n".format([c.name, c.soilLevel, c.sunLevel, c.waterLevel, c.state]))
	#random select between good ones
	if len(valid_cells) == 0:
		return null
	return valid_cells.pick_random()


func _on_map_map_initialized() -> void:
	_spawn_parasite()
