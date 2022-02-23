extends Node


var obiliskPos = preload("res://src/Objects/Interactive/Obilisk.tscn")

func _ready():
	call_deferred("spawn_obilisk")

func spawn_obilisk():
	var positions_array = get_children()
	#spawn obilisk random with a for loop
	for _i in range(0,1): #size of objects to spawn 
		var obilisk_spawn_index = round(rand_range(0,positions_array.size()-1)) #get random number between 0 and elements of array
		var obilisk_spawn_node = positions_array[obilisk_spawn_index] #get the node Position2D at random position
		var obilisk_clone = obiliskPos.instance() #initialize obilisk
		add_child(obilisk_clone) #spawn obilisk
		yield(get_tree().create_timer(0.1),"timeout")
		obilisk_clone.position = obilisk_spawn_node.position #positioning obilisk(global viewport)
		positions_array.remove(obilisk_spawn_index) # remove all obilisks after scene finish
		print("Obilisk placed") 
