extends Position2D
# Rig to move a child camera based on the player's input, to give them more forward visibility

onready var camera = $ShakingCamera

export var offset := Vector2(150.0, 150.0)
export var mouse_range := Vector2(100.0, 500.0)

var is_active := true

func _physics_process(_delta: float):
	update_position()

func update_position(_velocity: Vector2 = Vector2.ZERO):
	# Updates the camera rig's position based on the player's state and controller position
	if not is_active:
		return

	match Settings.controls:
		Settings.KBD_MOUSE, _:
			var mouse_position := get_local_mouse_position()
			var distance_ratio := clamp(mouse_position.length(), mouse_range.x, mouse_range.y) / mouse_range.y
			camera.position = distance_ratio * mouse_position.normalized() * offset

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			if $ShakingCamera.zoom > Vector2(1,1):
				$ShakingCamera.zoom = $ShakingCamera.zoom - Vector2(0.05,0.05)
				
		elif event.button_index == BUTTON_WHEEL_DOWN:
			if $ShakingCamera.zoom < Vector2(1.2,1.2): 
				$ShakingCamera.zoom = $ShakingCamera.zoom + Vector2(0.01,0.01)
