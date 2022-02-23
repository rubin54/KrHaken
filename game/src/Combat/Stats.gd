# Stats for the player or the monsters, to manage health, etc.
# Attach an instance of Stats to any object to give it health and stats.
extends Node

var cursorFullAmmo = load("res://assets/UI/Crosshair/eye_of_the_beholder 64x64_active.png")

export(int) var max_health = 5 setget set_max_health
var health = max_health setget set_health

export(int) var max_ammo = 1 setget set_max_ammo
var ammo = max_ammo setget set_ammo

signal no_health
signal health_changed(value)
signal max_health_changed(value)

var coins = 0
var best_score = 0

signal no_ammo
signal ammo_changed(value)
signal max_ammo_changed(value)

func update_ammo(var delta):
	ammo += delta
	emit_signal("ammo_changed",ammo)
	
func update_score(var delta):
	coins += delta

func load_score():
	var save_file = File.new()
	if !save_file.file_exists("user://savegame3.save"):
		return
	save_file.open_encrypted_with_pass("user://savegame3.save",File.READ,"dfghfdhgfd")
	
	var data = save_file.get_var()
	coins = data["score"]
	best_score = data["best_score"]
	save_file.close()

func save_score():
	print("saved")
	var save_file = File.new()
	save_file.open_encrypted_with_pass("user://savegame3.save",File.WRITE,"dfghfdhgfd")
	
	if coins > best_score:
		best_score = coins
	
	var data = {
		"score": coins,
		"best_score": best_score
	}
	save_file.store_var(data)
	save_file.close()

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
		
func set_max_ammo(value):
	max_ammo = value
	self.ammo = min(ammo, max_ammo)
	emit_signal("max_ammo_changed", max_ammo)

func set_ammo(value):
	ammo = value
	emit_signal("ammo_changed", ammo)
	if ammo <= 0:
		emit_signal("no_ammo")
	else:
		Input.set_custom_mouse_cursor(cursorFullAmmo,Input.CURSOR_ARROW,Vector2())

func _ready():
	self.health = max_health
	self.ammo = max_ammo
	
func handle_ui_health():
	if health == 5:
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_a").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_b").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_c").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_d").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_e").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritea").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spriteb").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritec").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Sprited").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritee").visible = false
		
	elif health == 4:
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_a").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_b").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_c").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_d").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_e").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritea").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spriteb").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritec").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Sprited").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritee").visible = false
		
	elif health == 3:
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_a").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_b").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_c").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_d").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_e").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritea").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spriteb").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritec").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Sprited").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritee").visible = false
	elif health == 2:
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_a").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_b").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_c").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_d").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_e").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritea").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spriteb").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritec").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Sprited").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritee").visible = false
	elif health == 1:
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_a").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_b").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_c").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_d").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_e").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritea").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spriteb").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritec").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Sprited").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritee").visible = false
	else:
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_a").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_b").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_c").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_d").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/ui_platzhalter/auge_e").visible = false
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritea").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spriteb").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritec").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Sprited").visible = true
		get_tree().get_root().get_node("/root/Node2D/UI/HealthUI/Node2D/Spritee").visible = true
