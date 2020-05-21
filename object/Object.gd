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
	$Background/Imagen.texture = res
	$Background/Imagen.texture.set_flags(1)
	$Background/Imagen.set_scale(Vector2(0.3,0.3))

func get_image():
	return image

func set_status(x):
	image = x
	var res = load(image)
	$Background/Imagen/Status.texture = res
	$Background/Imagen/Status.texture.set_flags(1)
	$Background/Imagen/Status/AnimationPlayer.play("scale")

func _on_Control_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			emit_signal("is_code")
