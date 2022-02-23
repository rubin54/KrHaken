extends Area2D

export var scene_path = ""


func _on_SceneTransition_body_entered(body):
	if body.is_in_group("Player") && GlobalSignals.obilisk_activated == true:
# warning-ignore:return_value_discarded
		get_tree().change_scene(scene_path)
		
	
