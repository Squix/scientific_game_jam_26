class_name Map
extends Node3D

var mapArray: Array[Cell]
var width: int = 10
var height: int = 10

var cellScene = preload("res://scenes/cell.tscn")

func getCell(_x:int , _z:int) -> Cell:
	return mapArray[width*_z + _x]	

func initMap() -> void:
	for _x in range(width):
		for _z in range (height):
			mapArray.push_back(instantiateCell(_x,_z))

func instantiateCell (_x:int, _z:int) -> Cell :
	var cellInstance : Cell = cellScene.instantiate()
	cellInstance.position.x = _x
	cellInstance.position.z = _z
	add_child(cellInstance)
	return cellInstance
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initMap()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
