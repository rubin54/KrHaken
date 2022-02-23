extends "res://src/Combat/DamageSource.gd"

var attack_cooldown_time = 500
var next_attack_time = 0
#var knockback_vector = Vector2.ZERO

func _ready():
	$AnimationPlayer.play("SETUP")

#if bullet hits, freeze, dont do damage
func _on_HurtBox_area_entered(_area):
	set_collision_mask_bit(17, 0)
	$LayerSwapH.start()

func attack():
	$CollisionShape2D.set_deferred("disabled",true)
	# Check if player can attack
	$Sprite.play("m_melee_att_vfx")
	var now = OS.get_ticks_msec()
	if now >= next_attack_time:
		# Play attack animation
		$AnimationPlayer.play("attack_medium")
		$CollisionShape2D.set_deferred("disabled",false)
		# Add cooldown time to current time
		next_attack_time = now + attack_cooldown_time

func _on_LayerSwapH_timeout():
	set_collision_mask_bit(17, 131072)
