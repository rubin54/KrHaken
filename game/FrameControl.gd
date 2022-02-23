extends Control

onready var frame_rect = $Frames
onready var scene_array = [load("res://assets/CutScene/frame 2.png"),load("res://assets/CutScene/frame 3.png"),load("res://assets/CutScene/frame 5.png"),load("res://assets/CutScene/frame 4.png"),load("res://assets/CutScene/frame 7.png"),load("res://assets/CutScene/frame 8.png"),load("res://assets/CutScene/frame 9.png"),load("res://assets/CutScene/frame 10.png")]
var index = 0

func _ready():
	frame_rect.texture = scene_array[0]

func _on_next_button_pressed():
	index += 1
	if index < scene_array.size():
		frame_rect.texture = scene_array[index]
	else:
		pass #change scene here

func _on_previous_button_pressed():
	index -= 1
	if index < scene_array.size():
		frame_rect.texture = scene_array[index]
	else:
		pass #change scene here
