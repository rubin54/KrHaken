extends Node

export(int) var MAX_ENEMY_COUNT = 2

var Enemy = preload("res://src/Enemy/Dummy.tscn")

onready var collider = $Spawn/CollisionShape2D


func _process(delta):
	#Enemy.connect("on_Dummy_died", get_parent(), "on_Dummy_died")    ## für endlos spawner  custom signal
	pass

func spawn_enemy():
	var new_enemy = Enemy.instance()
	new_enemy.global_position = calculate_random_spawn_position()
	call_deferred("add_child", new_enemy)

func calculate_random_spawn_position():
	var spawn_radius = collider.shape.radius

	var random_angle = randf() * 2 * PI
	var random_radius = randf() * spawn_radius / 2 + spawn_radius / 2

	return collider.global_position + Vector2(cos(random_angle) * random_radius, sin(random_angle) * random_radius)


func _on_Dummy_died():
	print("emittet")
	spawn_enemy()
	


