extends AnimationPlayer

# warning-ignore:unused_argument
func _on_IntroAnim_animation_finished(anim_name):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UI/UI_Scenes/CutsceneIntro.tscn")
