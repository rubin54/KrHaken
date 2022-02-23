extends AnimatedSprite

var loot_coin = preload("res://src/Objects/PickUps/LootCoin.tscn")
var ammo = preload("res://src/Objects/PickUps/Ammo.tscn")

func _on_Area2D_area_entered(area):
	if area.is_in_group("Bullets"):
		spawn_coin_on_death()
		spawn(ammo)
		#$brakesound.play()
		owner.queue_free()
	elif area.is_in_group("Melee"):
		spawn_coin_on_death()
		#$brakesound.play()
		owner.queue_free()

func spawn(item):
	var loot = item.instance()
	$"/root".call_deferred("add_child",loot)
	loot.global_position = global_position + Vector2.RIGHT.rotated(randf()*6)

func spawn_coin_on_death():
	spawn(loot_coin)
