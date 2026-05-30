class_name Cell
extends Node3D

enum CellState {containColza,containParasite,cut, dead}

var state : CellState = CellState.containColza

var fieldPos : Dictionary[String, int] = {"x":0, "z":0}

@onready var colza_alive = $offset/scale/Colza
@onready var colza_dead = $offset/scale/Colza_Dead
@onready var colza_cut = $offset/scale/Colza_Cut

func set_state(new_state: CellState):
	if(new_state == CellState.containParasite):
		print("Cell {0} contient le parasite".format([name]))
		var debug_material : Material = StandardMaterial3D.new()
		var debug_mesh = (colza_alive.find_child("Colza_BASE") as MeshInstance3D).mesh.duplicate(true)
		debug_material.albedo_color = Color.BLUE_VIOLET
		debug_mesh.surface_set_material(0, debug_material)
		(colza_alive.find_child("Colza_BASE") as MeshInstance3D).mesh = debug_mesh
		
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
