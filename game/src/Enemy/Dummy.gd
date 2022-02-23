extends Node2D


export var spawnDistance = 150
######################### EXPORT VAR ##########################
######################### ONREADY VAR ##########################
######################### PRELOAD VAR ##########################
var loot_coin = preload("res://src/Objects/PickUps/LootCoin.tscn")
var ammo = preload("res://src/Objects/PickUps/Ammo.tscn")
############################ VAR ###############################

#var knockback = Vector2.ZERO
signal playSound

var state = FROZEN  # start STATE
#########################    ENUM     ##########################
enum {
	IDLE,
	FROZEN
}
################################################################

func _ready():
	randomize()    
	

func _physics_process(_delta):

	#SIMPLE STATE MACHINE
	match state:
		IDLE:
			pass
		FROZEN: 
			pass        


func _on_HurtBox_area_entered(area):
	if area.is_in_group("Melee") and state == FROZEN:
		print("collided with Sword while frozen")
		$crumble.play() #play on destroy crumble sound
		emit_signal("playSound")
		queue_free()
		spawn(ammo)
		#spawn_coin_on_death()
		#spawn_ammo_on_death()
	elif area.is_in_group("Bullets"):
		print("get hit")
		#$FreezeTimer.start()
		$FrozenSound.play()
		$AnimationPlayer.play("Frozen_icon")
		state = FROZEN

func spawn(item):
	var loot = item.instance()
	$"/root".call_deferred("add_child",loot)
	loot.global_position = global_position + Vector2.RIGHT.rotated(randf()*6) * spawnDistance #
func _on_MousesDetector_mouse_entered():
	#$KinematicBody2D/Sprite/MousesDetector/Aura.visible = true
	$KinematicBody2D/Sprite/MousesDetector/AnimatedSprite.visible = true

func _on_MousesDetector_mouse_exited():
	#$KinematicBody2D/Sprite/MousesDetector/Aura.visible = false
	$KinematicBody2D/Sprite/MousesDetector/AnimatedSprite.visible = false


func _on_MeleeEnemyHookTarget_hooked_onto_from(_hook_position) -> void:
	$KinematicBody2D/CollisionShape2D.disabled = true
	$Layer.start()


func _on_Layer_timeout() -> void:
	$KinematicBody2D/CollisionShape2D.disabled = false
	
