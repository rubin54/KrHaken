extends TextureButton




func _on_Fullscreen_toggle_pressed():
	OS.set_window_fullscreen(!OS.window_fullscreen)
