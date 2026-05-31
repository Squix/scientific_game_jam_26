extends AudioStreamPlayer

func _on_game_init_game() -> void:
	play()


func _on_game_game_lost() -> void:
	stop()


func _on_game_game_won() -> void:
	stop()
