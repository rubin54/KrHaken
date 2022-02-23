extends CanvasLayer

export var reference_path = ""

func _on_quit_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene(reference_path)
