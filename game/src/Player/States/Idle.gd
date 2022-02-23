# Idle.gd
extends State

func unhandled_input(event):
	_parent.unhandled_input(event)

func physics_process(delta):
		_parent.physics_process(delta)

# Upon entering the state, we set the Player node's velocity to zero.
func enter(msg: Dictionary = {}):
	_parent.enter(msg)
# warning-ignore:standalone_expression
	_parent.max_speed
	_parent.velocity = Vector2.ZERO
	_parent.snap_vector.y = _parent.snap_distance

func exit():
	_parent.exit()
