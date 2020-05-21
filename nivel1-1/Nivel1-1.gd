extends Node2D

export(PackedScene) var Objeto
const objects_file = "res://data/objects.json"
var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var popup_status
var json
var score
var intentos
var time_left
var seleccionado

func _ready():
	# PopUp
	popup_status = 0
	$PopUp.visible = false
	# Childs
	add_child(audio)
	# Transition
	$Transition.visible = true
	$Transition/AnimationPlayer.play("fade-out")
	yield($Transition/AnimationPlayer, "animation_finished")
	$Transition.visible = false
	# Containers
	$Objects.visible = false
	$ObjectsSounds.visible = false
	$ObjectsOptions.visible = false
	# Vars
	score = 0
	intentos = 0
	time_left = 2
	seleccionado = 0
	# Functions
	$TopPanel.update_score(score)
	json = read_json()
	set_objects(json)
	set_sounds(1)
	set_options(json, 1)

func read_json():
	var file = File.new()
	if file.file_exists(objects_file):
		file.open(objects_file, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			return data
		else:
			printerr("Corrupted data!")
	else:
		printerr("File don't exist!")

func set_objects(x):
	var deck = Array()
	for i in x:
		deck.append(i)
	var indexList = range(deck.size())
	for i in range(deck.size()):
		randomize()
		var y = randi()%indexList.size()	
		for z in x:
			if z == deck[y]:
				var obj = Objeto.instance()
				obj.set_id(z)
				obj.set_nombre(x[z]["name"])
				obj.set_code(x[z]["code"])
				obj.set_sound(x[z]["sound"])
				obj.set_image(x[z]["image"])
				$Objects.add_child(obj)
		indexList.remove(y)
		deck.remove(y)

func set_sounds(x):
	var count = 0
	for i in $Objects.get_children():
		if count >= $Objects.get_child_count() - x:
			var obj = $Objects.get_child(count)
			$Objects.remove_child(i)
			$ObjectsSounds.add_child(obj)
			ogg = load(obj.get_sound())
			ogg.loop = false
			audio.stream = ogg
		else:
			count += 1

func set_options(x, agregar):
	# Distribucion de los objetos
	var all = Array()
	var options = Array()
	for i in x:
		var existe = false
		for j in $ObjectsSounds.get_children():
			if x[i]["code"] == j.code:
				existe = true
		if existe == false:
			all.append(i)
		else:
			options.append(i)

	# Inclucion de objetos extras
	var indexList = range(all.size())
	for i in range(agregar):
		randomize()
		var y = randi()%indexList.size()
		for z in all:
			if z == all[y]:
				options.append(z)
		indexList.remove(y)
		all.remove(y)

	# Set options to ObjectsOptions
	var card_x = 555
	var card_width = 170
	var in_list = range(options.size())
	for i in range(options.size()):
		randomize()
		var y = randi()%in_list.size()	
		for z in x:
			if z == options[y]:
				var obj = Objeto.instance()
				obj.set_id(z)
				obj.set_nombre(x[z]["name"])
				obj.set_code(x[z]["code"])
				obj.set_sound(x[z]["sound"])
				obj.set_image(x[z]["image"])
				obj.position = Vector2(card_x,500)
				obj.connect("is_code", self, "_is_code", [obj])
				card_x = card_x + card_width
				$ObjectsOptions.add_child(obj)
		in_list.remove(y)
		options.remove(y)

# Funcion que se ejecuta al clickear en un objeto
func _is_code(x):
	seleccionado += 1
	if seleccionado == 1:
		var existe = false
		for i in $ObjectsSounds.get_children():
			if i.code == x.code:
				existe = true
		if existe == true:
			correct(x)
		else:
			incorrect(x)

func correct(x):
	intentos += 1
	score += 1
	$TopPanel.update_score(score)
	$Timer.start()
	x.set_status("res://assets/icons/correct.png")
	audio.stop()
	$Main/VBox/Margin2/Escuchar.disabled = true

func incorrect(x):
	intentos += 1
	$Timer.start()
	x.set_status("res://assets/icons/incorrect.png")
	audio.stop()
	$Main/VBox/Margin2/Escuchar.disabled = true

# Timer
func _on_Timer_timeout():
	time_left -=1
	if time_left <= 0:
		next()

func next():
	# Timer
	$Timer.stop()
	# Containers
	$ObjectsOptions.visible = false
	# Vars
	time_left = 2
	seleccionado = 0	
	# Functions
	reset_sounds()
	reset_options()

	if intentos < 5:
		# Functions
		set_sounds(1)
		set_options(json, 1)
		$Main/VBox/Margin2/Escuchar.disabled = false
	else:
		if score >= 4:
			popup_status = 2
			$TopPanel/Margin1/ToMenu.disabled = true
			$PopUp/VBox/HBox/Margin1/Aceptar.texture_normal = load("res://assets/buttons/nivels/continuar-basic.png")
			$PopUp/VBox/HBox/Margin1/Aceptar.texture_pressed = load("res://assets/buttons/nivels/continuar-press.png")
			$PopUp/VBox/HBox/Margin2/Rechazar.texture_normal = load("res://assets/buttons/nivels/finalizar-basic.png")
			$PopUp/VBox/HBox/Margin2/Rechazar.texture_pressed = load("res://assets/buttons/nivels/finalizar-press.png")
			$PopUp.visible = true
		else:
			popup_status = 3
			$TopPanel/Margin1/ToMenu.disabled = true
			$PopUp/VBox/HBox/Margin1/Aceptar.texture_normal = load("res://assets/buttons/nivels/reintentar-basic.png")
			$PopUp/VBox/HBox/Margin1/Aceptar.texture_pressed = load("res://assets/buttons/nivels/reintentar-press.png")
			$PopUp/VBox/HBox/Margin2/Rechazar.texture_normal = load("res://assets/buttons/nivels/finalizar-basic.png")
			$PopUp/VBox/HBox/Margin2/Rechazar.texture_pressed = load("res://assets/buttons/nivels/finalizar-press.png")
			$PopUp.visible = true

func reset_sounds():
	for i in $ObjectsSounds.get_children():
		$ObjectsSounds.remove_child(i)

func reset_options():
	for i in $ObjectsOptions.get_children():
		$ObjectsOptions.remove_child(i)

# TopPanel
func _on_ToMenu_pressed():
	popup_status = 1
	$PopUp/VBox/HBox/Margin1/Aceptar.texture_normal = load("res://assets/buttons/nivels/si-basic.png")
	$PopUp/VBox/HBox/Margin1/Aceptar.texture_pressed = load("res://assets/buttons/nivels/si-press.png")
	$PopUp/VBox/HBox/Margin2/Rechazar.texture_normal = load("res://assets/buttons/nivels/no-basic.png")
	$PopUp/VBox/HBox/Margin2/Rechazar.texture_pressed = load("res://assets/buttons/nivels/no-press.png")
	$PopUp.visible = true

# Main
func _on_Escuchar_pressed():
	$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audio-press.png")
	audio.play()
	$Main/VBox/Margin2/Escuchar.disabled = true
	yield(audio, "finished")
	$Main/VBox/Margin2/Escuchar.disabled = false
	$ObjectsOptions.visible = true
	$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audio-basic.png")

# PopUp
func _on_Aceptar_pressed():
	$PopUp.visible = false
	$Transition.visible = true
	$Transition/AnimationPlayer.play("fade-in")
	yield($Transition/AnimationPlayer, "animation_finished")
	if popup_status == 1:
		get_tree().change_scene("res://title-screen/TitleScreen.tscn")
	if popup_status == 2:
		get_tree().change_scene("res://nivel1-2/Nivel1-2.tscn")
	if popup_status == 3:
		get_tree().change_scene("res://nivel1-1/Nivel1-1.tscn")

func _on_Rechazar_pressed():
	if popup_status == 1:
		$PopUp.visible = false
	else:
		$PopUp.visible = false
		$Transition.visible = true
		$Transition/AnimationPlayer.play("fade-in")
		yield($Transition/AnimationPlayer, "animation_finished")
		if popup_status == 2:
			get_tree().change_scene("res://title-screen/TitleScreen.tscn")
		if popup_status == 3:
			get_tree().change_scene("res://title-screen/TitleScreen.tscn")
