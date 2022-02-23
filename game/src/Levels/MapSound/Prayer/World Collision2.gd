extends Area2D



func _on_World_Collision2_area_entered(area: Area2D):
	if area.is_in_group("Bullets"):
		$BulletMissSound.play()
