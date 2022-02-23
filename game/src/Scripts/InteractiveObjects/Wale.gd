extends Node2D

func _process(_delta):
	position.x -= 1

func _on_Area2D_area_entered(area):
	if area.is_in_group("WaleDestroyer"):
		queue_free()

