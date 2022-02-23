extends Area2D

export var scene_path = ""


func _on_SceneTransition_body_entered(body):
	if body.is_in_group("Player") && SoulManager.soulsforPortal <= 1:
# warning-ignore:return_value_discarded
		get_tree().change_scene(scene_path)
	
