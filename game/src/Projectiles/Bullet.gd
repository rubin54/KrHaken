extends Area2D
class_name Bullet

export (int) var speed = 10
var spawnDistance = 100

onready var kill_timer = $KillTimer
var ammo = preload("res://src/Objects/PickUps/Ammo.tscn")

var direction := Vector2.ZERO
var team: int = -1

func _ready():
	kill_timer.start()
	pass

func _physics_process(_delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity

func set_direction(direction := Vector2.ZERO):
	self.direction = direction
	rotation += direction.angle()

func _on_KillTimer_timeout():
	queue_free()
	spawn(ammo)

func _on_Bullet_area_entered(area):
	if area.is_in_group("Enemy"):
		queue_free()
	if area.is_in_group("World"):
		queue_free()
		spawn(ammo)

func spawn(item):
	var loot = item.instance()
	$"/root".call_deferred("add_child",loot)
	loot.global_position = global_position + Vector2.RIGHT.rotated(randf()*6) * spawnDistance #
