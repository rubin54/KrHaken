extends KinematicBody2D

export var spawnDistance = 150
######################### EXPORT VAR ##########################
export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var E_SPEED = 55
######################### ONREADY VAR ##########################
onready var wanderController = $WanderController
onready var playerDetectionZone = $TargetDetectorRange
#onready var softCollision = $SoftCollision
######################### PRELOAD VAR ##########################
var loot_coin = preload("res://src/Objects/PickUps/LootCoin.tscn")
var ammo = preload("res://src/Objects/PickUps/Ammo.tscn")
############################ VAR ###############################

var bullet_scene = load("res://src/Projectiles/EnemyBullet.tscn")
#onready var player = "/root/Game/Player"
onready var player = get_parent().get_node("/root/Node2D/YSort/Player")

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
	FROZEN,
	ATTACK
}
################################################################

func _ready():
	randomize()    
	state = pick_random_state([IDLE, WANDER])  # pick random state 
	$BulletTimer.start()
	
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
			$BulletTimer.stop()
			$DamageSource/CollisionShape2D.disabled = true
		ATTACK:
			$AnimationPlayer.play("attack")
		
		
#	if softCollision.is_colliding():  #SoftCollision prevents opponents/enemys/obj from overlapping 
#		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta): 
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
#	sprite.flip_h = velocity.x < 0

func seek_player():           #  Opponent sees the player via Area2D and switches to CHASE State
	if playerDetectionZone.can_see_player():
		state = CHASE
		$walk.play()

func update_wander():         # Chooses between IDLE and WANDER, starts the timer and repeat
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1,3))

func pick_random_state(state_list):   #
	state_list.shuffle()              # 
	return state_list.pop_front()



# warning-ignore:unused_argument
func _on_HurtBox_body_entered(body):
	pass

func _on_HurtBox_area_entered(area):
	if area.is_in_group("Melee") and state == FROZEN:
		die()
		$DeathSound.play()
		spawn_coin_on_death()
		spawn_ammo_on_death()
	elif area.is_in_group("Bullets"):
		$Freeze.start()
		$FrozenSound.play()
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

func spawn_bullet():
	var b1 = bullet_scene.instance()
	b1.global_position = self.global_position
	b1.dir = Vector2(player.global_position.x - self.global_position.x,player.global_position.y - self.global_position.y).normalized()
	$"/root".add_child(b1)

func _on_Timer_timeout():
	spawn_bullet()
	$ShootSound.play()
#
func _on_AttackDetection_body_entered(body):
	if body.is_in_group("Player"):
		state = ATTACK
		
func _on_Hitbox_area_entered(area):
	if area.is_in_group("HurtboxPlayer"):
		$Hitbox.attack()

func _on_Freeze_timeout():
	state = IDLE
	spawn(ammo)
	$BulletTimer.start()
	$DamageSource/CollisionShape2D.disabled = false
