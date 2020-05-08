extends Area2D

var id
var nombre
var code
var sound
var image

func set_id(x):
	id = x

func set_nombre(x):
	nombre = x

func set_code(x):
	code = x

func set_sound(x):
	sound = x

func set_image(x):
	image = x
	var res = load(image)
	$AnimatedSprite/Sprite.texture = res
	$AnimatedSprite/Sprite.texture.set_flags(1)
	$AnimatedSprite/Sprite.set_scale(Vector2(0.1,0.1))
