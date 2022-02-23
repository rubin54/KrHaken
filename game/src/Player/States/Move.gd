extends State
# Parent state that abstracts and handles basic movement
# Move-related children states can delegate movement to it, or use its utility functions

export var max_speed = Vector2(100.0, 100.0)
export var acceleration_default = Vector2(35500.0, 35500.0)
export var FRICTION = 6000

var acceleration = acceleration_default

var snap_distance := 32.0
var snap_vector := Vector2(0, 32)

var velocity = Vector2.ZERO

func enter(_msg: Dictionary = {}):
	owner.hook.connect("hooked_onto_target", self, "_on_Hook_hooked_onto_target")
	#owner.stats.connect("damage_taken", self, "_on_Stats_damage_taken")
	#owner.pass_through.connect("body_exited", self, "_on_PassThrough_body_exited")
# warning-ignore:return_value_discarded

func exit():
	owner.hook.disconnect("hooked_onto_target", self, "_on_Hook_hooked_onto_target")
	#owner.stats.disconnect("damage_taken", self, "_on_Stats_damage_taken")
	#owner.pass_through.disconnect("body_exited", self, "_on_PassThrough_body_exited")

func get_input_axis():	
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

func physics_process(delta):
	get_input_axis()
	if Stats.health != 0:
		if(velocity == Vector2.ZERO):  #if none key is pressed
			apply_friction(FRICTION*delta)
		else:
			apply_motion(acceleration * delta)
		velocity = owner.move_and_slide_with_snap(velocity, snap_vector)
	

func _on_Hook_hooked_onto_target(target_global_position: Vector2):
	var to_target: Vector2 = target_global_position - owner.global_position
	if owner.is_on_floor() and to_target.y > 0.0:
		return

	_state_machine.transition_to("Hook", {target_global_position = target_global_position, velocity = velocity})

func apply_motion(acc_factor):
	velocity += velocity.normalized()*acc_factor
	
func apply_friction(friction_factor):
	if velocity.length() > friction_factor:
		velocity -= velocity.normalized()*friction_factor
	else:
		velocity = Vector2.ZERO

