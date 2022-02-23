extends StaticBody2D



func _on_MeleeEnemyHookTarget_hooked_onto_from(_hook_position):
	$block.disabled = true
	$Timer.start()


func _on_Timer_timeout():
	$block.disabled = false
