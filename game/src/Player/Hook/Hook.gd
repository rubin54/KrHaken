tool
extends Position2D
class_name Hook, "res://assets/icons/haken_klein.svg"
# Throws a raycast that can interact with Hookable bodies and calculate a pull vector towards those bodies.
# The raycast is updated manually for greater precision with where the player is aiming
# Draws the hook's range in the editor


# warning-ignore:unused_signal
signal hooked_onto_target(target_global_position)

onready var ray_cast= $RayCast2D
onready var arrow = $Arrow
onready var snap_detector = $SnapDetector
onready var cooldown = $Cooldown

var is_aiming := false setget set_is_aiming
var is_active := true setget set_is_active

onready var _radius: float = snap_detector.calculate_length()

func _ready():
	if Engine.editor_hint:
		update()


func _draw():
	if not Engine.editor_hint:
		return

	DrawingUtils.draw_circle_outline(self, Vector2.ZERO, snap_detector.calculate_length(), Color.lightgreen)


func can_hook():
	return is_active and snap_detector.has_target() and cooldown.is_stopped()


func get_aim_direction():
	var direction := Vector2.ZERO
	match Settings.controls:
		Settings.KBD_MOUSE, _:
			direction = (get_global_mouse_position() - global_position).normalized()
	return direction


func set_is_aiming(value):
	is_aiming = value
	Engine.time_scale = 0.05 if is_aiming == true else 1.0


func set_is_active(value):
	is_active = value
	set_process_unhandled_input(value)
