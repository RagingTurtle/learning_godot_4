extends CanvasLayer

func restart_game() -> void:
	get_tree().reload_current_scene()
	
func quit_game() -> void:
	get_tree().quit()
