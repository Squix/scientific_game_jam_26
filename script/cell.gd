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

var colzaCutFx = preload("res://scenes/vfx/Colza_cut_fx.tscn")

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
		var tween = create_tween()
		tween.tween_method(Shake.bind(randf()),0.0,1.0,1)
		tween.tween_callback(colza_alive.hide)
		tween.tween_callback(colza_dead.show)
		tween.tween_callback(parasite_dead.show)
	
	state = new_state

func Shake(delta:float,power: float):
	($offset/scale as Node3D).rotation.x = cos(delta*PI*10)*exp(-delta)/5*power
	($offset/scale as Node3D).rotation.z = sin(delta*PI*10)*exp(-delta)/10
	pass
		
var waterLevel: int = 1
const maxWaterLevel: int = 3
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

func setWaterLevelToMax():
	updateWaterLevel(maxWaterLevel-waterLevel)
	print(waterLevel)

func updateWaterLevel(_change:int):
	waterLevel += _change
	waterLevel = clamp(waterLevel,1,maxWaterLevel)
	if(waterLevel > 1):
		ground.mesh = groundMeshWet
		var scaleFactor:float = (waterLevel+1)*(1.0/(maxWaterLevel+1))
		ground.scale = Vector3(scaleFactor,scaleFactor,scaleFactor)
	else :
		ground.mesh = groundMeshBase
		ground.scale = Vector3(1,1,1)

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
	$offset/scale/ColzaCutFx.get_node("CPUParticles3D").restart()
	add_child(colzaCutFx.instantiate())
	colza_alive.hide()
	colza_cut.show()
	pass	
