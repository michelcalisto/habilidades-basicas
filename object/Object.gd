extends Area2D

var id
var nombre
var code
var sound
var image
signal is_code

func _ready():
	$Line2D.visible = false
	
func set_id(x):
	id = x

func set_nombre(x):
	nombre = x

func set_code(x):
	code = x

func set_sound(x):
	sound = x

func get_sound():
	return sound
	
func set_image(x):
	image = x
	var res = load(image)
	$AnimatedSprite/Sprite.texture = res
	$AnimatedSprite/Sprite.texture.set_flags(1)
	$AnimatedSprite/Sprite.set_scale(Vector2(0.1,0.1))

func get_image():
	return image
	
func _on_Object_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			$Line2D.visible = true
			print(id,code)
			emit_signal("is_code")


func _on_Control_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			print("si nose")
			#if self.is_in_group("deck"):
			#	emit_signal("in_deck")
			#else:
			#	if self.is_in_group("hand"):
			#		emit_signal("in_hand")
			#	else:
			#		if self.is_in_group("defense"):
			#			$Line2D.visible = true
			#			emit_signal("in_attack")
