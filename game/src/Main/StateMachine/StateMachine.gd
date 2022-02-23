# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name StateMachine
extends Node

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
export var initial_state := NodePath()

# The current active state. At the start of the game, we get the `initial_state`.
onready var state: State = get_node(initial_state) setget set_state
#For UI Debugger
onready var stateName := state.name

func _init():
	add_to_group("state_machine")

func _ready():
	# The states are children of the `Player` node so their `_ready()` 
	#callback will execute first.
	# That's why we wait for the `owner` to be ready first.
	yield(owner, "ready") 
	state.enter()
	
# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event):
	state.unhandled_input(event)

func _physics_process(delta):
	state.physics_process(delta)
	
# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_path: String, msg: Dictionary = {}):
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_path):
		return

	var target_state := get_node(target_state_path)
	
	state.exit()
	self.state = target_state
	state.enter(msg)

#to show actual state in the UI-Debuger
func set_state(value):
	state = value
	stateName = state.name
