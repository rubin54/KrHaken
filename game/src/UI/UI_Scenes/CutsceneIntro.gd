extends Control

func _ready():
	$AnimationPlayer.play("intro")

func _process(_delta):
	if Input.is_action_just_pressed("attack"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://src/UI/UI_Scenes/TitleScreen.tscn")

func _on_AnimationPlayer_animation_finished(_anim_name):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UI/UI_Scenes/TitleScreen.tscn")
