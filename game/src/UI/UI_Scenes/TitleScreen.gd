extends Node

var cursorTitlescreen = load("res://assets/UI/Crosshair/eye_of_the_beholder 64x64.png")
#start audiomanager to play music in titlescreen
func _ready():
	Stats.load_score()
	$Coins.text = "Souls: " + str(Stats.coins)
	Stats.health = 5
	$BubbleSound.play()
	Input.set_custom_mouse_cursor(cursorTitlescreen,Input.CURSOR_ARROW,Vector2(30.0,30.0))
