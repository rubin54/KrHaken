extends KinematicBody2D


func _ready():
	pass 

func _process(_delta):
	if GlobalSignals.obilisk_activated == true:
			$obelisk_eye_red.visible = true

func _on_Ditection_body_entered(body):
	if body.is_in_group("Player"):
		$OnPlayerEnters.text = str("")
		pass

func _on_Ditection_body_exited(_body):
	$OnPlayerEnters.text = str("")



