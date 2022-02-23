extends KinematicBody2D

onready var target_detector: Area2D = $TargetDetector


######################### EXPORT VAR ##########################
export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var E_SPEED = 55
######################### ONREADY VAR ##########################
onready var wanderController = $WanderController
onready var playerDetectionZone = $TargetDetector
#onready var softCollision = $SoftCollision
######################### PRELOAD VAR ##########################
var loot_coin = preload("res://src/Objects/PickUps/LootCoin.tscn")
############################ VAR ###############################

#enemy stats
var health = 100
var health_max = 100
var health_regeneration = 1

var froozen
var playerAttacked


var velocity = Vector2.ZERO
#var knockback = Vector2.ZERO

signal died

var state = IDLE  # start STATE
#########################    ENUM     ##########################
enum {
	IDLE,
	WANDER,
	CHASE,
	FROZEN
}
################################################################

func _ready():
	randomize()    
	state = pick_random_state([IDLE, WANDER])  # pick random state 

func _physics_process(delta):
	#froozen()
	
	#regenerates health
	health = min(health + health_regeneration * delta,health_max)
#	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
#	knockback = move_and_slide(knockback)

	#SIMPLE STATE MACHINE
	match state:
		IDLE:

			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			if wanderController.get_time_left() == 0:
				update_wander()

		WANDER:   # just random moving behavior , enemy is wandering aimless

			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= E_SPEED:
				update_wander()   # update state

		FROZEN:          
			velocity = velocity.move_toward(Vector2.ZERO, 0 * delta)



	#if softCollision.is_colliding():  #SoftCollision prevents opponents/enemys/obj from overlapping 
		#velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta): 
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
#	sprite.flip_h = velocity.x < 0


func update_wander():         # Chooses between IDLE and WANDER, starts the timer and repeat
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1,3))

func pick_random_state(state_list):   #
	state_list.shuffle()              # 
	return state_list.pop_front()



func _on_HurtBox_body_entered(body):
	pass
#	if body.is_in_group("Player") and state == FROZEN :
#		print("collided with Player")
#		#$AnimationPlayer.play("get_hit")


func _on_HurtBox_area_entered(area):
	if area.is_in_group("Melee") and state == FROZEN:
		print("collided with Sword while frozen")
		queue_free()
		spawn_ammo_on_death()
	elif area.is_in_group("Bullets"):
		print("get hit")
		$FreezeTimer.start()
		$AnimationPlayer.play("freezing")
		state = FROZEN


func die():
	emit_signal("died")
	queue_free()

func spawn_ammo_on_death():
	var loot = loot_coin.instance()
	get_tree().root.get_node("Game").call_deferred("add_child", loot)
	loot.position = position
	#Global.update_ammo(1)
	pass
	


func _on_FreezeTimer_timeout() -> void:
	state = IDLE
	print("idle")
