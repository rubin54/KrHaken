extends Area2D
class_name HookTarget
# Area2D the Hook can hook onto
# If is_one_shot is true, the player can only hook onto the point once

signal hooked_onto_from(hook_position)

onready var timer: Timer = $Timer

export var is_one_shot := false

const COLOR_ACTIVE: Color = Color(1, 1, 1)
const COLOR_INACTIVE: Color = Color(0.588235, 0.588235, 0.588235)

var is_active := true setget set_is_active

func _ready():
# warning-ignore:return_value_discarded
	timer.connect("timeout", self, "_on_Timer_timeout")

func _on_Timer_timeout():
	self.is_active = true

func hooked_from(hook_position: Vector2):
	self.is_active = false
	emit_signal("hooked_onto_from", hook_position)

func set_is_active(value:bool):
	is_active = value
	modulate = COLOR_ACTIVE if is_active else COLOR_INACTIVE

	if not is_active and not is_one_shot:
		timer.start()

# warning-ignore:unused_argument
func _on_MeleeEnemyHookTarget_area_entered(area):
	print("hit")
	set_collision_layer_bit(2, 4)
	$Sprite.visible = true
	$LayerSwap.start()

func _on_LayerSwap_timeout():
	Stats.set_ammo(Stats.ammo + 1)
	set_collision_layer_bit(2, 0)
	$Sprite.visible = false
