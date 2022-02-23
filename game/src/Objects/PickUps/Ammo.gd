extends Area2D

var getmagnet = false

func _physics_process(_delta):
	if getmagnet == false:
		global_position.y += 0

	var bodies = get_overlapping_areas()   
	for body in bodies :
		if body.name == "Collector":
			getmagnet = true
			global_position += (get_parent().get_node("/root/Node2D/YSort/Player").global_position - global_position).normalized() * 26

func _on_Ammo_body_entered(body):
	if body.name == "Player" and Stats.ammo == 0:
		Stats.set_ammo(Stats.ammo +1)
		get_tree().queue_delete(self)
	else:
		get_tree().queue_delete(self)


