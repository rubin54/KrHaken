extends Node2D
class_name Weapon

var cursorOutOfAmmo = load("res://assets/UI/Crosshair/eye_of_the_beholder 64x64_inactive.png")

export (PackedScene) var Bullet
export (int) var max_ammo: int = 10
export (bool) var semi_auto: bool = true

var team: int = -1

onready var end_of_gun = $EndOfGun
onready var attack_cooldown = $AttackCoolDown

func _physics_process(_delta):
	look_at(get_global_mouse_position())
	
func shoot():
	if Stats.ammo != 0  and Bullet != null:
		var bullet_instance = Bullet.instance()
		var direction = (end_of_gun.global_position - global_position).normalized()
		GlobalSignals.emit_signal("bullet_fired", bullet_instance, team, end_of_gun.global_position, direction)
		#attack_cooldown.start()
		Stats.set_ammo(Stats.ammo - 1)
		Input.set_custom_mouse_cursor(cursorOutOfAmmo,Input.CURSOR_ARROW,Vector2())

