extends Node2D

#FOR MELEE ENEMY
export(int) var MAX_ENEMY_COUNT = 2
var MAX_ENEMY_COUNT_DEATH = 0
onready var collider = $SpawnArea/CollisionShape2D
var Enemy = preload("res://src/Enemy/MeleeEnemy.tscn")

#FOR RANGE ENEMY
var Enemy_R = preload("res://src/Enemy/Ranged_Enemy.tscn")

#export(Array, PackedScene) var Enemys
#spawn node
onready var enemy = $Enemy

func _ready():
	$SpawnTimer.start()
	randomize()  # for shuffle() to actually randomize

func _process(_delta):
	if MAX_ENEMY_COUNT == MAX_ENEMY_COUNT_DEATH || MAX_ENEMY_COUNT <= MAX_ENEMY_COUNT_DEATH:
		$AnimatedSprite.play("Death")
		
func _on_SpawnTimer_timeout(): 
	if enemy.get_child_count() < MAX_ENEMY_COUNT:
		spawn_enemy()
		MAX_ENEMY_COUNT_DEATH += 1

	
func spawn_enemy(): # choose between two enemies and spawning on a circle shape
	var new_enemy = pick_random_enemy([Enemy, Enemy_R]).instance()
	new_enemy.global_position = calculate_random_spawn_position()
	enemy.add_child(new_enemy)

func pick_random_enemy(Enemies):   # "list" of enemies
	Enemies.shuffle()              #  mixing list 
	return Enemies.pop_front()     #  return a "random" enemy

func calculate_random_spawn_position():
	var spawn_radius = collider.shape.radius
	var random_angle = randf() * 2 * PI
	var random_radius = randf() * spawn_radius / 2 + spawn_radius / 2
	return collider.global_position + Vector2(cos(random_angle) * random_radius, sin(random_angle) * random_radius)
