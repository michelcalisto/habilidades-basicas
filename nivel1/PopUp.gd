extends Sprite

func update_info(x):
	$VBox/Margin/Info.text = str(x)

func update_textures_aceptar(x,y):
	$VBox/HBox/Margin1/Aceptar.texture_normal = load(str(x))
	$VBox/HBox/Margin1/Aceptar.texture_pressed = load(str(x))

func update_textures_rechazar(x,y):
	$VBox/HBox/Margin2/Rechazar.texture_normal = load(str(x))
	$VBox/HBox/Margin2/Rechazar.texture_pressed = load(str(x))

# PopUp Next Level
func set_nextlevel():
	$VBox/Margin.rect_min_size.y = 272
	$VBox/HBox.visible = false

func reset_nextlevel():
	$VBox/Margin.rect_min_size.y = 172
	$VBox/HBox.visible = true

# PopUp Final
func set_final():
	$VBox/HBox/Margin1.rect_min_size.x = 500
	$VBox/HBox/Margin2.visible = false
