extends Node2D

func _ready():
	$Timer.start()
	$Player.remove_child($Player/StateMachine)
	$Player.remove_child($Player/Hook)
	$Cutscene.play("FlyingInCircle")

func _on_Timer_timeout():
	get_tree().change_scene("res://src/Main/Game.tscn")
