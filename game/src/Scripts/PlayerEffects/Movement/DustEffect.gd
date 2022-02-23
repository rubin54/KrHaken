extends Position2D


var dust_scene = preload("res://Shader/PlayerEffects/Dust/Dust.tscn") 

func create_dust_effect():
	var dust_position = position + Vector2(0, 40)
	var dust
	for _i in range(-2, 3):
		dust = dust_scene.instance()
		dust.position = dust_position
		dust.scale.x *= _i/2.0
		dust.scale.y *= abs(_i/2.0)
		get_parent().add_child(dust)

