extends Node2D

export(PackedScene) var Objeto
const objects_file = "res://data/objects.json"
var audio1 = AudioStreamPlayer.new()
var audio2 = AudioStreamPlayer.new()
var audio3 = AudioStreamPlayer.new()
var audio4 = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var texture_normal = Texture.new()
var texture_pressed = Texture.new()
var texture_audio_pressed = Texture.new()
var json
var score
var intentos
var time_left
var seleccionado
var eleccion_correcta1
var eleccion_correcta2
var eleccion_correcta3
var segundo_audio

func _ready():
	$Main/VBox/HBox/Margin2/Escuchar.texture_normal
	# Icons
	$Correct.visible = false
	$Correct2.visible = false
	$Correct3.visible = false
	$Correct4.visible = false
	$Incorrect.visible = false
	$Incorrect2.visible = false
	$Incorrect3.visible = false
	$Incorrect4.visible = false
	# Childs
	add_child(audio1)
	add_child(audio2)
	add_child(audio3)
	add_child(audio4)
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
	eleccion_correcta1 = false
	eleccion_correcta2 = false
	eleccion_correcta3 = false
	segundo_audio = false
	# Functions
	$TopPanel.update_score(score)
	json = read_json()
	set_objects(json)
	set_sounds(4)
	set_options(json, 1)

func _process(delta):
	var cursor_pos = get_global_mouse_position()
	
	if $ObjectsOptions.get_child_count() != 0:
		var count = 0
		for i in $ObjectsOptions.get_children():
			if $ObjectsOptions.get_child(count).in_action == true:
				
				if $Main/VBox/HBox/VBox/HBox/Margin1/Panel1.get_global_rect().has_point(cursor_pos) and $Main/VBox/HBox/VBox/HBox/Margin1/Panel1.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Main/VBox/HBox/VBox/HBox/Margin1/Panel1.get_global_rect().position.x, $Main/VBox/HBox/VBox/HBox/Margin1/Panel1.get_global_rect().position.y, 1)
						$Main/VBox/HBox/VBox/HBox/Margin1/Panel1.set_slot_item(true)
				elif $Main/VBox/HBox/VBox/HBox/Margin2/Panel2.get_global_rect().has_point(cursor_pos) and $Main/VBox/HBox/VBox/HBox/Margin2/Panel2.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Main/VBox/HBox/VBox/HBox/Margin2/Panel2.get_global_rect().position.x, $Main/VBox/HBox/VBox/HBox/Margin2/Panel2.get_global_rect().position.y, 2)
						$Main/VBox/HBox/VBox/HBox/Margin2/Panel2.set_slot_item(true)
				elif $Main/VBox/HBox/VBox/HBox/Margin3/Panel3.get_global_rect().has_point(cursor_pos) and $Main/VBox/HBox/VBox/HBox/Margin3/Panel3.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Main/VBox/HBox/VBox/HBox/Margin3/Panel3.get_global_rect().position.x, $Main/VBox/HBox/VBox/HBox/Margin3/Panel3.get_global_rect().position.y, 3)
						$Main/VBox/HBox/VBox/HBox/Margin3/Panel3.set_slot_item(true)
				elif $Main/VBox/HBox/VBox/HBox/Margin4/Panel4.get_global_rect().has_point(cursor_pos) and $Main/VBox/HBox/VBox/HBox/Margin4/Panel4.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Main/VBox/HBox/VBox/HBox/Margin4/Panel4.get_global_rect().position.x, $Main/VBox/HBox/VBox/HBox/Margin4/Panel4.get_global_rect().position.y, 4)
						$Main/VBox/HBox/VBox/HBox/Margin4/Panel4.set_slot_item(true)
				elif $ObjectsOptions.get_child(count).liberado == true:
					$ObjectsOptions.get_child(count).reset_start_position()
					
			count += 1
			
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
			# Orden del audio
			obj.set_order_audio($ObjectsSounds.get_child_count()+1)
			$ObjectsSounds.add_child(obj)
			ogg = load(obj.get_sound())
			ogg.loop = false
			if countAudio == 0:
				audio1.stream = ogg
				countAudio += 1
			elif countAudio == 1:
				audio2.stream = ogg
				countAudio += 1
			elif countAudio == 2:
				audio3.stream = ogg
				countAudio += 1
			else:
				audio4.stream = ogg
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
#	var indexList = range(all.size())
#	for i in range(agregar):
#		randomize()
#		var y = randi()%indexList.size()
#		for z in all:
#			if z == all[y]:
#				options.append(z)
#		indexList.remove(y)
#		all.remove(y)

	# Set options to ObjectsOptions
	var card_x = 220
	var card_width = 150 + 10 + 40 + 5
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
				obj.position = Vector2(card_x,530)
				# Posicion inicial
				obj.set_start_position(card_x, 530)
				obj.connect("is_order_and_code", self, "_is_order_and_code", [obj])
				#obj.connect("is_code", self, "_is_code", [obj])
				card_x = card_x + card_width
				$ObjectsOptions.add_child(obj)
		in_list.remove(y)
		options.remove(y)


# Funcion que se ejecuta al soltar un elemento sobre un slot
func _is_order_and_code(x):
	print(seleccionado,segundo_audio)
	if seleccionado == 0:
		var existe = false
		for i in $ObjectsSounds.get_children():
			if x.order_slot != 0 and x.order_slot == i.order_audio:
				if i.code == x.code:
					existe = true
		if existe == true:
			eleccion_correcta1 = true
			correct(x.position.x, x.position.y)
		else:
			incorrect(x.position.x, x.position.y)
	elif seleccionado == 1:
		var existe = false
		for i in $ObjectsSounds.get_children():
			if x.order_slot != 0 and x.order_slot == i.order_audio:
				if i.code == x.code:
					existe = true
		if existe == true:
			eleccion_correcta2 = true
			correctNext(x.position.x, x.position.y)
		else:
			incorrectNext(x.position.x, x.position.y)
	elif seleccionado == 2:
		var existe = false
		for i in $ObjectsSounds.get_children():
			if x.order_slot != 0 and x.order_slot == i.order_audio:
				if i.code == x.code:
					existe = true
		if existe == true:
			eleccion_correcta3 = true
			correctNext3(x.position.x, x.position.y)
		else:
			incorrectNext3(x.position.x, x.position.y)
	elif seleccionado == 3:
		var existe = false
		for i in $ObjectsSounds.get_children():
			if x.order_slot != 0 and x.order_slot == i.order_audio:
				if i.code == x.code:
					existe = true
		if existe == true:
			correctNext4(x.position.x, x.position.y)
		else:
			incorrectNext4(x.position.x, x.position.y)

# Funcion que se ejecuta al clickear en un objeto
#func _is_code(x):
#	#seleccionado += 1
#	if seleccionado == 0:
#		var existe = false
#		for i in $ObjectsSounds.get_children():
#			if i.code == x.code:
#				existe = true
#		if existe == true:
#			eleccion_correcta = true
#			correct(x.position.x, x.position.y)
#		else:
#			incorrect(x.position.x, x.position.y)
#	elif seleccionado == 1 and segundo_audio == true:
#		var existe = false
#		for i in $ObjectsSounds.get_children():
#			if i.code == x.code:
#				existe = true
#		if existe == true:
#			correctNext(x.position.x, x.position.y)
#		else:
#			incorrectNext(x.position.x, x.position.y)
#	print(seleccionado)
	
func correct(x, y):
	seleccionado += 1
	$Correct.visible = true
	$Correct.position = Vector2(x, y)
	$Correct/AnimationPlayer.play("scala")

func incorrect(x, y):
	seleccionado += 1
	$Incorrect.visible = true
	$Incorrect.position = Vector2(x, y)
	$Incorrect/AnimationPlayer.play("scala")

func correctNext(x, y):
	seleccionado += 1
	$Correct2.visible = true
	$Correct2.position = Vector2(x, y)
	$Correct2/AnimationPlayer.play("scala")

func incorrectNext(x, y):
	seleccionado += 1
	$Incorrect2.visible = true
	$Incorrect2.position = Vector2(x, y)
	$Incorrect2/AnimationPlayer.play("scala")
	
func correctNext3(x, y):
	seleccionado += 1
	$Correct3.visible = true
	$Correct3.position = Vector2(x, y)
	$Correct3/AnimationPlayer.play("scala")

func incorrectNext3(x, y):
	seleccionado += 1
	$Incorrect3.visible = true
	$Incorrect3.position = Vector2(x, y)
	$Incorrect3/AnimationPlayer.play("scala")

func correctNext4(x, y):
	seleccionado += 1
	intentos += 1
	if eleccion_correcta1 == true and eleccion_correcta2 == true and eleccion_correcta3 == true:
		score += 1
		$TopPanel.update_score(score)
	print("ok")
	$Timer.start()
	$Correct4.visible = true
	$Correct4.position = Vector2(x, y)
	$Correct4/AnimationPlayer.play("scala")

func incorrectNext4(x, y):
	seleccionado += 1
	intentos += 1
	print("no")
	$Timer.start()
	$Incorrect4.visible = true
	$Incorrect4.position = Vector2(x, y)
	$Incorrect4/AnimationPlayer.play("scala")
	
func next():
	$Timer.stop()
	audio1.stop()
	audio2.stop()
	audio3.stop()
	audio4.stop()
	texture_audio_pressed = load("res://assets/buttons/button-audio-normal-02.png")
	$Main/VBox/HBox/Margin2/Escuchar.texture_normal = texture_audio_pressed
	# Icons
	$Correct.visible = false
	$Correct2.visible = false
	$Correct3.visible = false
	$Correct4.visible = false
	$Incorrect.visible = false
	$Incorrect2.visible = false
	$Incorrect3.visible = false
	$Incorrect4.visible = false
	# Functions
	reset_sounds()
	reset_options()
	# Containers
	$ObjectsOptions.visible = false
	# Vars
	time_left = 2
	seleccionado = 0
	eleccion_correcta1 = false
	eleccion_correcta2 = false
	eleccion_correcta3 = false
	segundo_audio = false
	
	$Main/VBox/HBox/VBox/HBox/Margin1/Panel1.set_slot_item(false)
	$Main/VBox/HBox/VBox/HBox/Margin2/Panel2.set_slot_item(false)
	$Main/VBox/HBox/VBox/HBox/Margin3/Panel3.set_slot_item(false)
	$Main/VBox/HBox/VBox/HBox/Margin4/Panel4.set_slot_item(false)
	if intentos < 2:
		# Functions
		set_sounds(4)
		set_options(json, 1)
	else:
		if score == 2:
			audio1.stop()
			audio2.stop()
			$PopupFinal.show()
			print("desbloqueado nivel")
		else:
			audio1.stop()
			audio2.stop()
			texture_normal = load("res://assets/buttons/button-normal-reintentar.png")
			$PopupFinal/VBox/HBox/Margin1/Continuar.texture_normal = texture_normal
			texture_pressed = load("res://assets/buttons/button-pressed-reintentar.png")
			$PopupFinal/VBox/HBox/Margin1/Continuar.texture_pressed = texture_pressed
			$PopupFinal.show()
			print("fin")

func reset_sounds():
	for i in $ObjectsSounds.get_children():
		$ObjectsSounds.remove_child(i)

func reset_options():
	for i in $ObjectsOptions.get_children():
		$ObjectsOptions.remove_child(i)

# TopPanel
func _on_ToMenu_pressed():
	$PopupToMenu.show()

# Main
func _on_Escuchar_pressed():
	texture_audio_pressed = load("res://assets/buttons/button-audio-pressed-01.png")
	$Main/VBox/HBox/Margin2/Escuchar.texture_normal = texture_audio_pressed
	audio1.play()
	#$ObjectsOptions.visible = true
	yield(audio1, "finished") 
	audio2.play()
	segundo_audio = true
	print(segundo_audio)
	yield(audio2, "finished")
	audio3.play()
	yield(audio3, "finished")
	audio4.play()
	yield(audio4, "finished")
	$ObjectsOptions.visible = true
	texture_audio_pressed = load("res://assets/buttons/button-audio-normal-02.png")
	$Main/VBox/HBox/Margin2/Escuchar.texture_normal = texture_audio_pressed

# PopupToMenu
func _on_Si_pressed():
	$PopupToMenu.hide()
	$Transition.visible = true
	$Transition/AnimationPlayer.play("fade-in")
	yield($Transition/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://title-screen/TitleScreen.tscn")

func _on_No_pressed():
	$PopupToMenu.hide()

# Timer
func _on_Timer_timeout():
	time_left -=1
	if time_left <= 0:
		next()

# PopupFinal
func _on_Finalizar_pressed():
	$PopupFinal.hide()
	$Transition.visible = true
	$Transition/AnimationPlayer.play("fade-in")
	yield($Transition/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://title-screen/TitleScreen.tscn")

func _on_Continuar_pressed():
	if score == 2:
		$PopupFinal.hide()
		$Transition.visible = true
		$Transition/AnimationPlayer.play("fade-in")
		yield($Transition/AnimationPlayer, "animation_finished")
		get_tree().change_scene("res://title-screen/TitleScreen.tscn")
	else:
		$PopupFinal.hide()
		$Transition.visible = true
		$Transition/AnimationPlayer.play("fade-in")
		yield($Transition/AnimationPlayer, "animation_finished")
		get_tree().change_scene("res://nivel2-4/Nivel2-4.tscn")
