extends AnimatedSprite

var loot_coin = preload("res://src/Objects/PickUps/LootCoin.tscn")
var ammo = preload("res://src/Objects/PickUps/Ammo.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	if area.is_in_group("Bullets"):
		spawn_coin_on_death()
		#$brakesound.play()
		get_tree().queue_delete(self)
		$Light2D.visible = false
		$Particles2D.visible = false
		spawn(ammo)
	elif area.is_in_group("Melee"):
		spawn_coin_on_death()
		#$brakesound.play()
		get_tree().queue_delete(self)
		$Light2D.visible = false
		$Particles2D.visible = false
		spawn(ammo)
		
func spawn(item):
	var loot = item.instance()
	$"/root".call_deferred("add_child",loot)
	loot.global_position = global_position + Vector2.RIGHT.rotated(randf()*6)

func spawn_coin_on_death():
	spawn(loot_coin)
