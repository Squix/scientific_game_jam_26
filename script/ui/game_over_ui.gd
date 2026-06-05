extends Control
class_name GameOverUI

@onready var title = $CenterContainer/Panel/MarginContainer/VBoxContainer/VBoxContainer/VBoxContainer/Title
@onready var label = $CenterContainer/Panel/MarginContainer/VBoxContainer/VBoxContainer/VBoxContainer/Label
@onready var score_container = $CenterContainer/Panel/MarginContainer/VBoxContainer/VBoxContainer/ScoreContainer
@onready var score_label = score_container.get_node("./Score")


func show_score():
	score_container.show()
	
func hide_score():
	score_container.hide()

func set_title(new_title: String):
	title.text = new_title
	
func set_label(new_label: String):
	label.text = new_label

func set_score_label(new_score_label: String):
	score_label.text = new_score_label
