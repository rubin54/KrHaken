extends Area2D

var player = null


#if player equal 0 then return false
func can_see_player():
	return player != null

func _on_TargetDetector_body_entered(body):
	player = body


func _on_TargetDetector_body_exited(_body):
	player = null

