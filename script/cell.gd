class_name Cell
extends Node3D

var containColza: bool  = true

func KillColza():
	$CSGBox3D.material.albedo_color = Color.RED
