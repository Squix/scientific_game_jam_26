class_name Cell
extends Node3D

enum CellState {containColza,containParasite,cut, dead}

var state : CellState = CellState.containColza

var fieldPos : Dictionary[String, int] = {"x":0, "z":0}

@onready var colza_alive = $offset/scale/Colza
@onready var colza_dead = $offset/scale/Colza_Dead
@onready var colza_cut = $offset/scale/Colza_Cut
@onready var parasite = $offset/scale/Parasite
@onready var parasite_dead = $offset/scale/ParasiteDead

@onready var ground : MeshInstance3D = $offset/ground

@export var SHOW_DEBUG_PARASITE = false

var groundMeshBase = preload("res://Assets/mesh/groundMeshBase.tres")
var groundMeshWet = preload("res://Assets/mesh/groundMeshWet.tres")

func set_state(new_state: CellState):
	if(new_state == CellState.containParasite && SHOW_DEBUG_PARASITE):
		print("Cell {0} contient le parasite".format([name]))
		var debug_material : Material = StandardMaterial3D.new()
		var debug_mesh = (colza_alive.find_child("Colza_BASE") as MeshInstance3D).mesh.duplicate(true)
		debug_material.albedo_color = Color.BLUE_VIOLET
		debug_mesh.surface_set_material(0, debug_material)
		(colza_alive.find_child("Colza_BASE") as MeshInstance3D).mesh = debug_mesh
		
	if(new_state == CellState.dead):
		colza_alive.hide()
		colza_dead.show()
		parasite_dead.show()
		
	state = new_state

var waterLevel: int = 1
var soilLevel: int = 1
var sunLevel: int = 1

func initCell():
	waterLevel = 1
	soilLevel = randi_range(1,2)
	sunLevel = 2
	$offset/scale.rotate_y(randi_range(0,3)*PI/2)

func playWindAnim():
	if(state == CellState.containColza):
		var animPlayer = (colza_alive.get_node("AnimationPlayer") as AnimationPlayer)
		if(animPlayer.current_animation == "Wind" and animPlayer.is_playing()):
			animPlayer.stop()
		animPlayer.play("Wind",-1,3,false)

	

func updateWaterLevel(_change:int):
	waterLevel += _change
	waterLevel = clamp(waterLevel,1,2)
	if(waterLevel == 2):
		ground.mesh = groundMeshWet
	else :
		ground.mesh = groundMeshBase
	
func updateSoilLevel(_change:int):
	soilLevel += _change
	soilLevel = clamp(soilLevel,1,2)
	
func updateSunLevel(_change:int):
	sunLevel += _change
	sunLevel = clamp(sunLevel,1,2)

func open_colza():
	if state == CellState.containColza || CellState.containParasite:
		if state == CellState.containParasite:
			parasite.show()
		(colza_alive.get_node("AnimationPlayer") as AnimationPlayer).play("Opening")
		await get_tree().create_timer(2.0).timeout
		(colza_alive.get_node("AnimationPlayer") as AnimationPlayer).play("Closing")
		parasite.hide()
	
func KillColza():
	set_state(CellState.dead)


func CutColza():
	set_state(CellState.cut)
	colza_alive.hide()
	colza_cut.show()
	pass	
