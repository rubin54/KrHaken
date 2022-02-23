extends Position2D


func _ready():
	play()

func play():
	$AnimationPlayer.play("impact")

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()


func _on_AnimationPlayer_tree_exited():
		pass #print("leaving tree. Bye!")
