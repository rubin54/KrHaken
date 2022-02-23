extends Node2D

onready var bullet_manager = $BulletManager

func _ready():
# warning-ignore:return_value_discarded
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	GlobalSignals.obilisk_activated = false
# warning-ignore:standalone_expression
	Stats.ammo += 1

func _process(_delta):
	Stats.load_score()
	$UI/Coins.text = str(Stats.coins)
