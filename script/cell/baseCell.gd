extends Node

@onready var ground : MeshInstance3D = $offset/ground

var groundMeshBase = preload("res://Assets/mesh/groundMeshBase.tres")
var groundMeshRich = preload("res://Assets/mesh/groundMeshRich.tres")
var groundMeshWet = preload("res://Assets/mesh/groundMeshWet.tres")

func initCell():
	updateGround()
	
func updateGround():
	
	pass

func updateContent():
	pass
