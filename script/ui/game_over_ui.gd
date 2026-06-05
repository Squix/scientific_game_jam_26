extends Control
class_name GameOverUI

@onready var title = $CenterContainer/Panel/MarginContainer/VBoxContainer/VBoxContainer/Title
@onready var label = $CenterContainer/Panel/MarginContainer/VBoxContainer/VBoxContainer/Label

func set_title(new_title: String):
	title.text = new_title
	
func set_label(new_label: String):
	label.text = new_label
