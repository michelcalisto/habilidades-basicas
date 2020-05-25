extends Area2D

var id
var nombre
var code
var sound
var image
signal is_code
var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()

func _ready():
	# Childs
	add_child(audio)

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
	$Background/Imagen.set_scale(Vector2(0.37,0.37))

func get_image():
	return image

func set_status(x):
	image = x
	var res = load(image)
	$Background/Status.texture = res
	$Background/Status.texture.set_flags(1)
	$Background/ColorRect/AnimationPlayer.play("fa")
	$Background/Status/AnimationPlayer.play("scale")

func _on_Control_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			emit_signal("is_code")

func set_sound_victory():
	ogg = load("res://assets/sounds/Ganar.ogg")
	ogg.loop = false
	audio.stream = ogg
	audio.play()

func set_sound_lose():
	ogg = load("res://assets/sounds/Perder.ogg")
	ogg.loop = false
	audio.stream = ogg
	audio.play()
