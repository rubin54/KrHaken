extends KinematicBody2D
class_name Player

var directionsIdle = ["idle_right", "idle_bottom_right", "idle_bottom", "idle_bottom_left", "idle_left", "idle_top_left", "idle_top", "idle_top_right"]
var directionsMove = ["move_right", "move_down_right", "move_down", "move_down_left", "move_left", "move_up_left", "move_up", "move_up_right"]
var directionsAttack = ["attack_right","attack_down_right","attack_down", "attack_down_left", "attack_left", "attack_up_left", "attack_up", "attack_up_right"]
var facing = Vector2()
var player : Player
var move_direction = Vector2()

onready var state_machine: StateMachine = $StateMachine

onready var hook = $Hook

onready var skin = $Skin
onready var collider = $CollisionShape2D setget ,get_collider

onready var camera_rig = $CameraRig
onready var shaking_camera = $CameraRig/ShakingCamera
#onready var pass_through= $PassThrough

var is_active := true setget set_is_active

func _ready():
# warning-ignore:return_value_discarded
	Stats.connect("no_health", self, "_on_Stats_no_health")
	$AnimationPlayer.play("Shadow")
	$AnimationPlayer.play("dust")
	player = owner as Player

func take_damage(source):
	Stats.take_damage(source)

func set_is_active(value):
	is_active = value
	if not collider:
		return
	collider.disabled = not value
	hook.is_active = value

func get_collider() -> CollisionShape2D:
	return collider
	
func _physics_process(_delta):
	movement()
	
func movement():
	move_direction = Vector2()
	
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	
	if Stats.health != 0:
		move_direction.x = int(RIGHT) - int(LEFT)
		move_direction.y = int(DOWN) - int(UP)
		
		if LEFT || RIGHT || UP || DOWN:
			if Input.is_action_pressed("attack"):
				attacking()
			else:
				facing = move_direction
				var animation = direction2strMove(facing)
				$AnimatedSprite.play(animation)
		elif Input.is_action_pressed("attack"):
			attacking()
		else:
			var animationIdle = direction2strIdle(facing)
			$AnimatedSprite.play(animationIdle)
	
func attacking():
	facing = move_direction
	var animationAttack = direction2strAttack(facing)
	$AnimatedSprite.play(animationAttack)

func direction2strAttack(direction):
	var angle = direction.angle()
	if angle < 0:
		angle += 2 * PI
	var indexAttack = round(angle / PI * 4)
	return directionsAttack[indexAttack]

func direction2strIdle(direction):
	var angle = direction.angle()
	if angle < 0:
		angle += 2 * PI
	var indexIdle = round(angle / PI * 4)
	return directionsIdle[indexIdle]
	
func direction2strMove(direction):
	var angle = direction.angle()
	if angle < 0:
		angle += 2 * PI
	var indexMove = round(angle / PI * 4)
	return directionsMove[indexMove]

func _on_Stats_no_health():
	Stats.coins *= 0.20
	var r = round(Stats.coins)
	Stats.coins = r
	Stats.save_score()
	$HurtBox.set_collision_layer_bit(17, 0)
	$AnimationPlayer.play("death")
	$DeathSound.play()
	no_move()
	$deathdelay.start()

func _on_HurtBox_area_entered(area):
	Stats.health -= area.damage
	$CameraRig/ShakingCamera.set_is_shaking(true)
	$AnimationPlayer.play("hit")
	$Ui_Eye_Open.play()
	$Hurt.play()

func deathscreen():   # change scene to Deathscreen
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UI/UI_Scenes/DeathScreen.tscn")

func _on_deathdelay_timeout():  # Timer Delay for Fadeout Deathscreen
	deathscreen()

func no_move():
	move_direction = Vector2.ZERO
