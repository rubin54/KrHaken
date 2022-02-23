extends Node2D

# Nodes references
var tilemap
var tree_tilemap

# Spawner variables
export var spawn_area = Rect2(50, 150, 700, 700)
export var max_enemys = 5
export var start_enemys = 1
var enemy_count = 0
var enemy_scene = preload("res://src/Enemy/MeleeEnemy.tscn")

# Random number generator
var rng = RandomNumberGenerator.new()

func _ready():
	# Get tilemaps references
	tilemap = get_tree().root.get_node("Game/YSort/Node2D/BasicEnvironment")
	tree_tilemap = get_tree().root.get_node("Game/YSort/Node2D/Objects")
	
	# Initialize random number generator
	rng.randomize()
	
	# Create enemy
	for _i in range(start_enemys):
		instance_skeleton()
	enemy_count = start_enemys

func instance_skeleton():
	# Instance the skeleton scene and add it to the scene tree
	var enemy = enemy_scene.instance()
	add_child(enemy)
	
	# Place the enemy in a valid position
	var valid_position = false
	while not valid_position:
		enemy.position.x = spawn_area.position.x + rng.randf_range(0, spawn_area.size.x)
		enemy.position.y = spawn_area.position.y + rng.randf_range(0, spawn_area.size.y)
		valid_position = test_position(enemy.position)

	# Play enemy's birth animation
	#enemy.arise()

#func _draw():
#	var radius = 20
#	draw_rect(spawn_area,Color(0.2,0.2,1.0,0.5))

func test_position(position : Vector2):
# Check if the cell type in this position is ground or something else
	var cell_coord = tilemap.world_to_map(position)
	var cell_type_id = tilemap.get_cellv(cell_coord)
	var ground_or_sand = (cell_type_id == tilemap.tile_set.find_tile_by_name("Floor")) || (cell_type_id == tilemap.tile_set.find_tile_by_name("Sand"))
	
	# Check if there's a obstacle in this position
	cell_coord = tree_tilemap.world_to_map(position)
	cell_type_id = tree_tilemap.get_cellv(cell_coord)
	var no_obstacles = (cell_type_id != tilemap.tile_set.find_tile_by_name("Candles") || (cell_type_id == tilemap.tile_set.find_tile_by_name("Top")))
	
	# If the two conditions are true, the position is valid
	return ground_or_sand and no_obstacles

#func arise():
#	#other_animation_playing = true
#	$AnimatedSprite.play("birth")
	
func _on_Timer_timeout():
	# Every second, check if we need to instantiate a skeleton
	if enemy_count < max_enemys:
		instance_skeleton()
		enemy_count = enemy_count + 1
