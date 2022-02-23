extends State


func unhandled_input(event):
	if event.is_action_pressed("aim"):
		owner.is_aiming = not owner.is_aiming
	elif event.is_action_pressed("hook"):
		_state_machine.transition_to("Fire")
		$AudioStreamPlayer.play()


func physics_process(_delta):
	var cast: Vector2 = owner.get_aim_direction() * owner._radius
	var angle := cast.angle()
	owner.ray_cast.cast_to = cast
	owner.arrow.rotation = angle
	owner.snap_detector.rotation = angle
	owner.ray_cast.force_raycast_update()

