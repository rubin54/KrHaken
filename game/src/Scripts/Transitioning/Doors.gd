extends Node2D

func _process(_delta):
	if GlobalSignals.obilisk_activated == true:
		$SceneTransition/door_closed/door_open.visible = true
		#$SceneTransition2/door_closed/door_open.visible = true
