extends Area2D

var playerEntered = false

func _on_Interactive_area_entered(area):
	if area.is_in_group("OpferAltar"):
		playerEntered = true
		
func _input(event):
	if event.is_action("enter") && playerEntered ==true:
		if SoulManager.soulsforPortal >= 1 and Stats.coins != 0:
			#yield(get_tree().create_timer(2.0),"timeout")
			#$Sacrifice.play()
			SoulManager.soulsforPortal -= 1
			Stats.update_score(-1)
			Stats.save_score()

func _on_Interactive_area_exited(_area):
	playerEntered = false
