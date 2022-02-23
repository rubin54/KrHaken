extends Area2D
class_name triggerscene

func _process(_delta):
	$AnimationPlayer.play("rotate")

func _on_GameCutscene_body_entered(body):
	if body.is_in_group("Player"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://TriggerEvents/GameCutscene.tscn")
		queue_free()
		

