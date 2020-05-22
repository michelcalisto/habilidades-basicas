extends Node2D

export(PackedScene) var Objeto
const objects_file = "res://data/animals.json"
var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var popup_status
var json
var score_level
var intentos_level
var time_left
var seleccionado


var level
var score_total


# Nivel 2
var audio2 = AudioStreamPlayer.new()
var eleccion_correcta

var user_score

func _ready():
	$PopUp/VBox/HBox/Margin3.visible = false
	$Main.update_indicaciones("ESCUCHA CON ATENCION.\n\nPRESIONA EL ANIMAL ESCUCHADO.")
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
	score_level = 0
	intentos_level = 0
	time_left = 2
	seleccionado = 0
	
	level = 1
	score_total = 0
	#$TopPanel.update_level(level)
	
	# Functions
	$TopPanel.update_score(score_total)
	json = read_json()
	set_objects(json)
	set_sounds(1)
	set_options(json, 1)
	
	# Nivel 2
	eleccion_correcta = false
	
	user_score = 0

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
	var countAudio = 0
	for i in $Objects.get_children():
		if count >= $Objects.get_child_count() - x:
			var obj = $Objects.get_child(count)
			$Objects.remove_child(i)
			$ObjectsSounds.add_child(obj)
			ogg = load(obj.get_sound())
			ogg.loop = false
			if countAudio == 0:
				audio.stream = ogg
				countAudio += 1
			else:
				audio2.stream = ogg
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
	var card_x = 640
	for i in range(options.size()-1):
		card_x = card_x - 85
	#var card_x = 555
	
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
	if level == 1:
		if seleccionado == 0:
			var existe = false
			for i in $ObjectsSounds.get_children():
				if i.code == x.code:
					existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)
	if level == 2:
		if seleccionado == 0:
			var existe = false
			for i in $ObjectsSounds.get_children():
				if i.code == x.code:
					existe = true
			if existe == true:
				eleccion_correcta = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionado == 1:
			var existe = false
			for i in $ObjectsSounds.get_children():
				if i.code == x.code:
					existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)
	if level == 3:
		if seleccionado == 0:
			var existe = false
			for i in $ObjectsSounds.get_children():
				if i.code == x.code:
					existe = true
			if existe == true:
				incorrect(x)
			else:
				correct(x)

func correct(x):
	if level == 1:
		seleccionado += 1
		intentos_level += 1
		score_level += 1
		score_total += 1
		$TopPanel.update_score(score_total)
		x.set_status("res://assets/icons/correct.png")
		audio.stop()
		$Timer.start()
	if level == 2 and seleccionado == 1:
		seleccionado += 1
		intentos_level += 1
		if eleccion_correcta == true:
			score_level += 1
			score_total += 1
			$TopPanel.update_score(score_total)
		x.set_status("res://assets/icons/correct.png")
		audio.stop()
		audio2.stop()
		$Timer.start()
	if level == 2 and seleccionado == 0:
		seleccionado += 1
		x.set_status("res://assets/icons/correct.png")
	if level == 3:
		seleccionado += 1
		intentos_level += 1
		score_level += 1
		score_total += 1
		$TopPanel.update_score(score_total)
		x.set_status("res://assets/icons/correct.png")
		audio.stop()
		audio2.stop()
		$Timer.start()
	
func incorrect(x):
	if level == 1:
		seleccionado += 1
		intentos_level += 1
		x.set_status("res://assets/icons/incorrect.png")
		audio.stop()
		$Timer.start()
	if level == 2 and seleccionado == 1:
		seleccionado += 1
		intentos_level += 1
		x.set_status("res://assets/icons/incorrect.png")
		audio.stop()
		$Timer.start()
	if level == 2 and seleccionado == 0:
		seleccionado += 1
		x.set_status("res://assets/icons/incorrect.png")
	if level == 3:
		seleccionado += 1
		intentos_level += 1
		x.set_status("res://assets/icons/incorrect.png")
		audio.stop()
		$Timer.start()

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
	# Nivel 2
	eleccion_correcta = false
	
	if intentos_level < 5:
		if level == 1:
			# Functions
			set_sounds(1)
			set_options(json, 1)
		if level == 2:
			set_sounds(2)
			set_options(json, 1)
		if level == 3:
			set_sounds(2)
			set_options(json, 1)
	else:
		if score_level >= 4:
			if level == 3:
				popup_status = 2
				$PopUp.update_info("FELICITACIONES HAS COMPLETADO\nTODOS LOS NIVELES\n\nPUNTAJE FINAL : "+str(score_total))
				$TopPanel/Margin1/ToMenu.disabled = true
				$PopUp/VBox/HBox/Margin1.visible = false
				$PopUp/VBox/HBox/Margin2.visible = false
				$PopUp/VBox/HBox/Margin3.visible = true
				#obj.position = Vector2(card_x,500)
				#$PopUp/VBox/HBox/Margin2.position = Vector2(125,0)
				#$PopUp/VBox/HBox/Margin2.set_position(Vector2(125,0))
				#$PopUp/VBox/HBox/Margin2.set_size(Vector2(504,100))
				$PopUp/VBox/HBox/Margin1/Aceptar.visible = false
				$PopUp/VBox/HBox/Margin2/Rechazar.visible = true
				$PopUp/VBox/HBox/Margin2/Rechazar.texture_normal = load("res://assets/buttons/nivels/finalizar-basic.png")
				$PopUp/VBox/HBox/Margin2/Rechazar.texture_pressed = load("res://assets/buttons/nivels/finalizar-press.png")
				$PopUp.visible = true
				$Main/VBox/Margin2/Escuchar.visible = false
			else:
				$TimerPopUp.start()
				popup_status = 2
				$PopUp.update_info("FELICITACIONES SIGUE AVANZANDO")
				$TopPanel/Margin1/ToMenu.disabled = true
				$PopUp/VBox/HBox/Margin1/Aceptar.visible = false
				$PopUp/VBox/HBox/Margin2/Rechazar.visible = false
				$PopUp.visible = true
				$Main/VBox/Margin2/Escuchar.visible = false
		else:
			popup_status = 3
			$PopUp.update_info("SIGUELO INTENTANDO")
			$TopPanel/Margin1/ToMenu.disabled = true
			$PopUp/VBox/HBox/Margin1/Aceptar.visible = true
			$PopUp/VBox/HBox/Margin2/Rechazar.visible = true
			$PopUp/VBox/HBox/Margin1/Aceptar.texture_normal = load("res://assets/buttons/nivels/reintentar-basic.png")
			$PopUp/VBox/HBox/Margin1/Aceptar.texture_pressed = load("res://assets/buttons/nivels/reintentar-press.png")
			$PopUp/VBox/HBox/Margin2/Rechazar.texture_normal = load("res://assets/buttons/nivels/finalizar-basic.png")
			$PopUp/VBox/HBox/Margin2/Rechazar.texture_pressed = load("res://assets/buttons/nivels/finalizar-press.png")
			$PopUp.visible = true
			$Main/VBox/Margin2/Escuchar.visible = false

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
	if level == 1 and seleccionado == 0:
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audio-press.png")
		audio.play()
		$Main/VBox/Margin2/Escuchar.disabled = true
		yield(audio, "finished")
		$Main/VBox/Margin2/Escuchar.disabled = false
		$ObjectsOptions.visible = true
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audio-basic.png")
	if level == 2 and (seleccionado == 0 or seleccionado == 1):
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audio-press.png")
		audio.play()
		$Main/VBox/Margin2/Escuchar.disabled = true
		yield(audio, "finished")
		audio2.play()
		yield(audio2, "finished")
		$Main/VBox/Margin2/Escuchar.disabled = false
		$ObjectsOptions.visible = true
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audio-basic.png")
	if level == 3 and seleccionado == 0:
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audio-press.png")
		audio.play()
		$Main/VBox/Margin2/Escuchar.disabled = true
		yield(audio, "finished")
		audio2.play()
		yield(audio2, "finished")
		$Main/VBox/Margin2/Escuchar.disabled = false
		$ObjectsOptions.visible = true
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audio-basic.png")

# PopUp
func _on_Aceptar_pressed():
	if popup_status == 1:
		$PopUp.visible = false
		$Transition.visible = true
		$Transition/AnimationPlayer.play("fade-in")
		yield($Transition/AnimationPlayer, "animation_finished")
		get_tree().change_scene("res://title-screen/TitleScreen.tscn")
#	if popup_status == 2:
#		next_level(score_level, score_total, level+1)
	if popup_status == 3:
		reintentar(user_score, level)
		$PopUp.visible = false
		$Main/VBox/Margin2/Escuchar.visible = true

func _on_Rechazar_pressed():
	if popup_status == 1:
		$PopUp.visible = false
		$Main/VBox/Margin2/Escuchar.visible = true
	else:
		$PopUp.visible = false
		$Transition.visible = true
		$Transition/AnimationPlayer.play("fade-in")
		yield($Transition/AnimationPlayer, "animation_finished")
		if popup_status == 2 or popup_status == 3:
			get_tree().change_scene("res://title-screen/TitleScreen.tscn")


func next_level(s,t,l):
	if l == 2:
		$Main.update_indicaciones("\n\nPRESIONA LOS ANIMALES QUE ESCUCHES.")
	if l == 3:
		$Main.update_indicaciones("\n\nPRESIONA EL ANIMAL NO ESCUCHADO.")
	
	$Main/VBox/Margin2/Escuchar.visible = true
	user_score = t
	# Timer
	$Timer.stop()
	$TimerPopUp.stop()
	# Containers
	$ObjectsOptions.visible = false
	# Vars
	time_left = 2
	seleccionado = 0	
	# Functions
	reset_sounds()
	reset_options()
	
	# PopUp
	popup_status = 0
	$PopUp.visible = false
	# Childs
	add_child(audio2)
	# Containers
	$ObjectsOptions.visible = false
	# Vars
	score_level = 0
	intentos_level = 0
	time_left = 2
	seleccionado = 0
	
	level = l
	score_total = t
	$TopPanel.update_level(level)
	
	# Functions
	$TopPanel.update_score(score_total)
	json = read_json()
	set_objects(json)
	set_sounds(2)
	set_options(json, 1)

	eleccion_correcta = false

func reintentar(s,l):
	$Main/VBox/Margin2/Escuchar.visible = true
	#user_score = s
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
	
	# PopUp
	popup_status = 0
	$PopUp.visible = false
	# Childs
	add_child(audio2)
	# Containers
	$ObjectsOptions.visible = false
	# Vars
	score_level = 0
	intentos_level = 0
	time_left = 2
	seleccionado = 0
	
	level = l
	score_total = s
	$TopPanel.update_level(level)
	
	# Functions
	$TopPanel.update_score(score_total)
	json = read_json()
	set_objects(json)
	if level == 1:
		set_sounds(1)
	else:
		set_sounds(2)
	set_options(json, 1)

	eleccion_correcta = false


func _on_TimerPopUp_timeout():
	time_left -=1
	if time_left <= 0:
		$PopUp.visible = false
		if popup_status == 2:
			next_level(score_level, score_total, level+1)


func _on_Finalizar_pressed():
	$PopUp.visible = false
	$Transition.visible = true
	$Transition/AnimationPlayer.play("fade-in")
	yield($Transition/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://title-screen/TitleScreen.tscn")
