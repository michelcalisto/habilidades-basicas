extends Area2D

var id
var nombre
var code
var sound
var image
signal is_order_and_code
var in_action
var liberado
var start_position_x
var start_position_y
var order_audio
var order_slot

func _ready():
	in_action = false
	liberado = false
	order_audio = 0
	order_slot = 0

func _process(delta):
	if in_action:
		self.position = get_global_mouse_position()

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

func set_start_position(x,y):
	start_position_x = x
	start_position_y = y

func set_order_audio(x):
	order_audio = x

func _on_Control_gui_input(event):
	if event.is_action_pressed("left_click") and order_slot == 0:
		in_action = true
		liberado = false
	if event.is_action_released("left_click"):
		liberado = true

func reset_start_position():
	in_action = false
	liberado = false
	self.position = Vector2(start_position_x, start_position_y)
	order_slot = 0
	
func set_obj_slot(x, y, z):
	in_action = false
	liberado = false
	self.position = Vector2(x+80, y+110)
	order_slot = z
	emit_signal("is_order_and_code")
