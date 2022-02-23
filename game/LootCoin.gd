extends Area2D

func _on_LootCoin_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().queue_delete(self)
		Stats.update_score(1)  #here we can generate random coin value based on coinsshare and drop chance
		Stats.save_score() #put in player die function, so coins update properly
