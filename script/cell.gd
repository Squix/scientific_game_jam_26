class_name Cell
extends Node3D

enum CellState {containColza,containParasite,cut, dead}

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
	$scale/offset/Colza.visible = false
	$scale/offset/Colza_Dead.visible = true
	pass

func CutColza():
	$scale/offset/Colza.visible = false
	$scale/offset/Colza_Cut.visible= true
	pass
