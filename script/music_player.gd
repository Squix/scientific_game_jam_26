extends AudioStreamPlayer

func _on_game_init_game() -> void:
	play()


func _on_game_game_lost(_score) -> void:
	stop()


func _on_game_game_won(_score) -> void:
	stop()
