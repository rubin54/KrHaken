extends Node2D

onready var bullet_manager = $BulletManager

func _ready():
# warning-ignore:return_value_discarded
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	GlobalSignals.obilisk_activated = false


func _process(_delta):
	Stats.load_score()
	$UI/Coins.text = str(Stats.coins)
	$YSort/OpferAltar/Souls.text = str(SoulManager.soulsforPortal) + "/600"
	input()


func input():
	if Input.is_action_just_pressed("ui_down"):
		$YSort/Tutorial/start/wasd_stone/s.visible = true
	elif Input.is_action_just_pressed("ui_up"):
		$YSort/Tutorial/start/wasd_stone/w.visible = true
	elif Input.is_action_just_pressed("ui_left"):
		$YSort/Tutorial/start/wasd_stone/a.visible = true
	elif Input.is_action_just_pressed("ui_right"):
		$YSort/Tutorial/start/wasd_stone/d.visible = true
	elif Input.is_action_just_pressed("shoot"):
		$YSort/Tutorial/Core_Mechanics/Shoot/tutorial_mouse_click/shoot.visible = true
	elif Input.is_action_just_pressed("hook"):
		$YSort/Tutorial/Core_Mechanics/Hook/tutorial_mouse_click/hook2.visible = true
#	elif Input.is_action_just_pressed("attack"):
#		$YSort/Tutorial/Core_Mechanics/Melee/tutorial_mouse_click3/melee.visible = true


func _on_Timer_timeout():
	$YSort/Tutorial/start/wasd_stone/s.visible = false
	$YSort/Tutorial/start/wasd_stone/w.visible = false
	$YSort/Tutorial/start/wasd_stone/a.visible = false
	$YSort/Tutorial/start/wasd_stone/d.visible = false
	$YSort/Tutorial/Core_Mechanics/Shoot/tutorial_mouse_click/shoot.visible = false 
	$YSort/Tutorial/Core_Mechanics/Hook/tutorial_mouse_click/hook2.visible = false
	#$YSort/Tutorial/Core_Mechanics/Melee/tutorial_mouse_click3/melee.visible = false
