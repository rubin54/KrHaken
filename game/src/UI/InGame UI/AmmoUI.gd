extends Control

var ammo = 4 setget set_ammo
var max_ammo = 4 setget set_max_ammo

onready var ammoUIFull = $AmmoUIFull
onready var ammoUIEmpty = $AmmoUIEmpty

func set_ammo(value):
	ammo = clamp(value,0,max_ammo)
	if ammoUIFull != null:
		ammoUIFull.rect_size.x = ammo * 267   #267 cause of  size of the texture

func set_max_ammo(value):
	max_ammo = max(value,1)
	self.ammo = min(ammo,max_ammo)
	if ammoUIEmpty != null:
		ammoUIEmpty.rect_size.x = max_ammo * 267
	
func _ready():
	self.max_ammo = Stats.max_ammo
	self.ammo = Stats.ammo
# warning-ignore:return_value_discarded
	Stats.connect("ammo_changed",self,"set_ammo")
# warning-ignore:return_value_discarded
	Stats.connect("max_ammo_changed",self,"set_max_ammo")
