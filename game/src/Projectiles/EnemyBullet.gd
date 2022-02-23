extends Area2D

var dir = Vector2(1,0)
export var bullet_speed = 800

export var damage := 1
var direction := Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	self.position += dir * delta * bullet_speed



func _on_EnemyBullet_area_entered(area):
	if area.is_in_group("HurtboxPlayer"):
		queue_free()
	if area.is_in_group("World"):
		queue_free()
