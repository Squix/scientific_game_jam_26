extends Node

var mouseScreenPos: Vector2 = Vector2()
var mouseWorldPos: Vector3 = Vector3()

signal map_clicked(worldPos:Vector3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouseScreenPos = get_viewport().get_mouse_position()
	var result = getWorldPosFromScreen(mouseScreenPos)
	if(result):
		mouseWorldPos = getWorldPosFromScreen(mouseScreenPos)

func getWorldPosFromScreen(_position: Vector2):
	var from = %"MainCamera".project_ray_origin(_position)
	var to = %MainCamera.project_ray_normal(_position)
	return Plane.PLANE_XZ.intersects_ray(from,to)

func _input(event):
	if event.is_action_pressed("click"):
		onClick(event.position)

func onClick(_position: Vector2):
	map_clicked.emit(mouseWorldPos)
	


func _on_ui_new_tool_selected(newTool: Player.tool) -> void:
	pass # Replace with function body.
