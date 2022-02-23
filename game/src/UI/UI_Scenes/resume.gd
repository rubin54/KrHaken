extends Button

export(bool) var start_focused = false

func _ready():
	if(start_focused):
		grab_focus()
		
#self conncted signals
# warning-ignore:return_value_discarded
	connect("mouse_entered",self,"_on_Button_mouse_entered")
# warning-ignore:return_value_discarded
	connect("pressed",self,"_on_Button_Pressed")
#grab focus with mouse
func _on_Button_mouse_entered():
	grab_focus()
