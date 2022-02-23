extends KinematicBody2D

export var spawnDistance = 150
######################### EXPORT VAR ##########################
export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var E_SPEED = 55
######################### ONREADY VAR ##########################
onready var wanderController = $WanderController
onready var playerDetectionZone = $TargetDetector
onready var softCollision = $SoftCollision
######################### PRELOAD VAR ##########################
var loot_coin = preload("res://src/Objects/PickUps/LootCoin.tscn")
var ammo = preload("res://src/Objects/PickUps/Ammo.tscn")
############################ VAR ###############################

var froozen
var playerAttacked

var velocity = Vector2.ZERO

signal died

var state = IDLE  # start STATE
#########################    ENUM     ##########################
enum {
	IDLE,
	WANDER,
	CHASE,
	FROZEN,
	ATTACK
}

func _ready():
	randomize()    
	state = pick_random_state([IDLE, WANDER])  # pick random state 

func _physics_process(delta):
	#SIMPLE STATE MACHINE
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			if wanderController.get_time_left() == 0:
				update_wander()
				seek_player()
				
		WANDER:   # just random moving behavior , enemy is wandering aimless

			if wanderController.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wanderController.target_position, delta)
			if global_position.distance_to(wanderController.target_position) <= E_SPEED:
				update_wander()   # update state
				seek_player()     #Player is near , change state CHASE
			
		CHASE:

			var _player = playerDetectionZone.player    # if player is near, chase  else IDLE
			if _player != null:
				accelerate_towards_point(_player.global_position,delta)
			else:
				state = IDLE
			
		FROZEN:          
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

		ATTACK:
			$AnimationPlayer.play("attack")
		
		
	if softCollision.is_colliding():  #SoftCollision prevents opponents/enemys/obj from overlapping 
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)
	if get_slide_count() > 0:
		wanderController.update_target_position()

func accelerate_towards_point(point, delta): 
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

func seek_player():           #  Opponent sees the player via Area2D and switches to CHASE State
	if playerDetectionZone.can_see_player():
		state = CHASE

func update_wander():         # Chooses between IDLE and WANDER, starts the timer and repeat
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1,3))

func pick_random_state(state_list):   #
	state_list.shuffle()              # 
	return state_list.pop_front()

func _on_HurtBox_area_entered(area):
	if area.is_in_group("Melee") and state == FROZEN:
		$DeathSound.play()
		die()
		spawn_coin_on_death()
		spawn_ammo_on_death()
	elif area.is_in_group("Bullets"):
		$FrozenSound.play()
		$Hurt.play()
		$FreezeTimer.start()
		$AnimationPlayer.play("frozen")
		state = FROZEN


func die():
	emit_signal("died")
	$AnimationPlayer.play("die")
	
func spawn_coin_on_death():
	spawn(loot_coin)

func spawn_ammo_on_death():
	spawn(ammo)

func spawn(item):
	var loot = item.instance()
	$"/root".call_deferred("add_child",loot)
	loot.global_position = global_position + Vector2.RIGHT.rotated(randf()*6) * spawnDistance #
	
func _on_FreezeTimer_timeout():
	state = IDLE
	Stats.update_ammo(1)

func _on_AttackDetection_body_entered(body):
	if body.is_in_group("Player"):
		state = ATTACK


func _on_Hitbox_area_entered(area):
	if area.is_in_group("HurtboxPlayer"):
		$Hitbox.attack()
