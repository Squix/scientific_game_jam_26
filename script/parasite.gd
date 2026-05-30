class_name Parasite
extends Node

@onready var field : Map = %Map

func spawn_parasite():
	#get field
	#get a random cell
	#change state of this random cell
	var random_cell : Cell = field.getCellUnsafe(randi_range(0, field.width), randi_range(0, field.height))
	
func start_turn():
	pass

func end_turn():
	pass
