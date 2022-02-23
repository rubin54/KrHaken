extends Node2D
onready var bullet_manager = $BulletManager

func _ready():
# warning-ignore:return_value_discarded
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	GlobalSignals.obilisk_activated = false
	
# warning-ignore:unused_argument
func _process(delta):
	Stats.load_score()
	$UI/Coins.text = str(Stats.coins)
