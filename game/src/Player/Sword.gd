extends "res://src/Combat/DamageSource.gd"

var attack_cooldown_time = 500
var next_attack_time = 0

func _ready():
	$AnimationPlayer.play("SETUP")

func _input(event):
	$MeleeAttackRange/CollisionShape2D.set_deferred("disabled",true)
	if event.is_action_pressed("attack"):
	# Check if player can attack
		$Sprite.play("player_att_vfx")
		var now = OS.get_ticks_msec()
		if now >= next_attack_time:
			# Play attack animation
			$AnimationPlayer.play("attack_medium")
			$MeleeAttackRange/CollisionShape2D.set_deferred("disabled",false)
			$Stomp.play()
			# Add cooldown time to current time
			next_attack_time = now + attack_cooldown_time

#if player attacking the obilisk, area of obilisk will be destroyed, and the next room door will open
func _on_MeleeAttackRange_area_entered(area):
	if area.is_in_group("Obilisk"):
		$Activation.play()
		GlobalSignals.obilisk_activated = true 
		area.get_parent().get_node("Ditection").queue_free() #so the obilisk can be activated only once
		print("activated")

