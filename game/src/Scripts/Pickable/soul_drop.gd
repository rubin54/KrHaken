extends Position2D

var coin_randamizer : RandomNumberGenerator = RandomNumberGenerator.new()


func _drop_loot_tier_1():
	coin_randamizer.randomize()
	var loot_percent:int = coin_randamizer.randi_range(0,100)

	if loot_percent >= 0:
		if loot_percent <= 2 || loot_percent == 2:
			print("20 Coins/2% chance")
			Stats.update_score(20)  #here we can generate random coin value based on coinsshare and drop chance
			Stats.save_score() #put in player die function, so coins update properly
		elif loot_percent >= 10 && loot_percent <= 40:
			print("10 Coins/10%-40% Chance")
			Stats.update_score(10)  #here we can generate random coin value based on coinsshare and drop chance
			Stats.save_score() #put in player die function, so coins update properly
		elif loot_percent >= 40:
			#add_child(coin_instance)
			print("2 Coins/40% or >40% Chance")
			Stats.update_score(2)  #here we can generate random coin value based on coinsshare and drop chance
			Stats.save_score() #put in player die function, so coins update properly

