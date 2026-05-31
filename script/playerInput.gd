extends Node

var mouseScreenPos: Vector2 = Vector2()
var mouseWorldPos: Vector3 = Vector3()
var mouseMapCoord: Vector2i = Vector2i()

signal map_clicked(worldPos:Vector3)
signal mouseChangedCoord(coords:Vector2i)

var map_ready = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(not map_ready):
		return
	mouseScreenPos = get_viewport().get_mouse_position()
	var result = getWorldPosFromScreen(mouseScreenPos)
	if(result):
		mouseWorldPos = getWorldPosFromScreen(mouseScreenPos)
		var newMouseCoord = %Map.worldPosToCellCoord(mouseWorldPos)
		if(newMouseCoord.x != mouseMapCoord.x or newMouseCoord.y != mouseMapCoord.y):
			mouseMapCoord = newMouseCoord
			mouseChangedCoord.emit(newMouseCoord)
			var cell = %Map.getCellSafe(newMouseCoord.x,newMouseCoord.y)
			if(cell):
				cell.playWindAnim()

func getWorldPosFromScreen(_position: Vector2):
	var from = get_viewport().get_camera_3d().project_ray_origin(_position)
	var to = get_viewport().get_camera_3d().project_ray_normal(_position)
	return Plane.PLANE_XZ.intersects_ray(from,to)

func _input(event):
	if event.is_action_pressed("click"):
		onClick(event.position)

func onClick(_position: Vector2):
	map_clicked.emit(mouseWorldPos)
	


func _on_ui_new_tool_selected(newTool: Player.tool) -> void:
	pass # Replace with function body.


func _on_map_map_initialized() -> void:
	map_ready = true


func _on_game_reset_game() -> void:
	map_ready = false
