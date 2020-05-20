extends Area2D

var id
var nombre
var code
var sound
var image
signal is_code

func set_id(x):
	id = x

func gett_id():
	return id

func set_nombre(x):
	nombre = x

func get_nombre():
	return nombre

func set_code(x):
	code = x

func get_code():
	return code

func set_sound(x):
	sound = x

func get_sound():
	return sound
	
func set_image(x):
	image = x
	var res = load(image)
	$AnimatedSprite/Sprite.texture = res
	$AnimatedSprite/Sprite.texture.set_flags(1)
	$AnimatedSprite/Sprite.set_scale(Vector2(0.3,0.3))

func get_image():
	return image
