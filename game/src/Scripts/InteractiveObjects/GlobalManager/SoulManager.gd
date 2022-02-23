extends Node

onready var soulsforPortal = 600

func _process(_delta):
	if soulsforPortal == 0:
		print("u can enter the boss room")
