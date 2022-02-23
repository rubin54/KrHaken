extends Node

onready var bullet_manager = $BulletManager

func _process(_delta):
	Stats.load_score()
	$UI/Coins.text = "Coins: " + str(Stats.coins)

func _ready():
# warning-ignore:return_value_discarded
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	GlobalSignals.obilisk_activated = false


func _unhandled_input(_event):
#	if event.is_action_pressed("restart"):  #if died
#		get_tree().reload_current_scene()
#	elif event.is_action_pressed("toggle_full_screen"):
#		OS.window_fullscreen = not OS.window_fullscreen
	pass
