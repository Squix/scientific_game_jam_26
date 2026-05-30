class_name Cell
extends Node3D

enum CellState {containColza, containParasite, dead}



func KillColza():
	$CSGBox3D.material.albedo_color = Color.RED
