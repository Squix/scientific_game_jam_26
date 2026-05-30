class_name Cell
extends Node3D

enum CellState {containColza,containParasite,cut, dead}

var state : CellState = CellState.containColza

@onready var colza_alive = $offset/scale/Colza
@onready var colza_dead = $offset/scale/Colza_Dead
@onready var colza_cut = $offset/scale/Colza_Cut

func set_state(new_state: CellState):
	if(new_state == CellState.containParasite):
		print("Cell {0} contient le parasite".format([name]))
	state = CellState.containColza

var waterLevel: int = 1
var soilLevel: int = 1
var sunLevel: int = 1

func initCell():
	waterLevel = randi_range(1,2)
	soilLevel = randi_range(1,2)
	sunLevel = randi_range(1,2)

func _ready() -> void:
	pass
	
func KillColza():
	colza_alive.hide()
	colza_dead.show()

func CutColza():
	colza_alive.hide()
	colza_cut.show()
	pass
