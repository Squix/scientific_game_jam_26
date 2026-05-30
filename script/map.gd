class_name Map
extends Node3D

var mapArray: Array[Cell]
var width: int = 10
var height: int = 10

var cellScene = preload("res://scenes/cell.tscn")

func getCellSafe(_x:int , _z:int):
	if _x >=0 and _x < width and _z >= 0 and _z<height:
		return mapArray[width*_z + _x]
	return null

func getCellUnsafe(_x:int , _z:int) -> Cell:
	return mapArray[width*_z + _x]	
	
func getAdjacentCellsTo(cell: Cell) -> Array[Variant]:
	var cell_pos = cell.fieldPos
	var adjacent_cells = []
	#up
	adjacent_cells.append(getCellSafe(cell_pos["x"], cell_pos["z"]-1))
	#down
	adjacent_cells.append(getCellSafe(cell_pos["x"], cell_pos["z"]+1))
	#left
	adjacent_cells.append(getCellSafe(cell_pos["x"]-1, cell_pos["z"]))
	#right
	adjacent_cells.append(getCellSafe(cell_pos["x"]+1, cell_pos["z"]))
	#corner up-left
	adjacent_cells.append(getCellSafe(cell))
	
	return adjacent_cells.filter(func(c): return c is Cell)

func _initMap() -> void:
	for _z in range (height):
		for _x in range(width):
			mapArray.push_back(instantiateCell(_x,_z))

func instantiateCell (_x:int, _z:int) -> Cell :
	var cellInstance : Cell = cellScene.instantiate()
	cellInstance.position.x = _x
	cellInstance.position.z = _z
	cellInstance.initCell()
	cellInstance.fieldPos = {"x":_x, "z":_z}
	add_child(cellInstance)
	return cellInstance

func worldPosToCellCoord(_position: Vector3) -> Vector2i:
	var localPos = _position -  position
	return Vector2i(localPos.x,localPos.z)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = -width/2
	position.z = -height/2

func _on_game_manager_init_game() -> void:
	_initMap()
