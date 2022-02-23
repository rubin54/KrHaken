extends Area2D



func _on_OpferAltar_body_entered(body):
	if body.is_in_group("Player"):
		print("press E")
		$PlayerEnters.text = "Press -E-"
   


func _on_OpferAltar_body_exited(_body):
	$PlayerEnters.text = ""
