extends Node2D


onready var bullet_manager = $BulletManager

func _process(_delta):
	Stats.load_score()
	$UI/Coins.text = "Coins: " + str(Stats.coins)

func _ready():
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	GlobalSignals.obilisk_activated = false
