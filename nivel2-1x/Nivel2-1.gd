extends Node2D

export(PackedScene) var Objeto
const objects_file = "res://data/objects.json"
var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var texture_normal = Texture.new()
var texture_pressed = Texture.new()
var texture_audio_pressed = Texture.new()
var json
var score
var intentos
var time_left
var seleccionado

func _ready():
	$Main/VBox/Margin2/Escuchar.texture_normal
	# Icons
	$Correct.visible = false
	$Incorrect.visible = false
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

func _process(delta):
	var cursor_pos = get_global_mouse_position()
	
	if $ObjectsOptions.get_child_count() != 0:
		var count = 0
		for i in $ObjectsOptions.get_children():
			if $ObjectsOptions.get_child(count).in_action == true:
				
				if $Panel1.get_global_rect().has_point(cursor_pos):
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panel1.get_global_rect().position.x, $Panel1.get_global_rect().position.y, 1)
						#$Panel1.set_code_obj($ObjectsOptions.get_child(count).code)
				elif $Panel2.get_global_rect().has_point(cursor_pos):
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panel2.get_global_rect().position.x, $Panel2.get_global_rect().position.y, 2)
				elif $ObjectsOptions.get_child(count).liberado == true:
					$ObjectsOptions.get_child(count).reset_start_position()
					
			count += 1
		
#		if $ObjectsOptions.get_child(0).in_action == true:
#			if $Panel1.get_global_rect().has_point(cursor_pos):
#				print("1")
#				if $ObjectsOptions.get_child(0).dejado == true:
#					$ObjectsOptions.get_child(0).set_position_new($Panel1.get_global_rect().position.x, $Panel1.get_global_rect().position.y, $Panel1/MarginContainer/Label.text)
#					$ObjectsOptions.get_child(0).reset_new(1)
#					$Panel1.set_code_obj($ObjectsOptions.get_child(0).code)
#			if $Panel2.get_global_rect().has_point(cursor_pos):
#				print("2")
#				if $ObjectsOptions.get_child(0).dejado == true:
#					$ObjectsOptions.get_child(0).set_position_new($Panel2.get_global_rect().position.x, $Panel2.get_global_rect().position.y, $Panel2/MarginContainer/Label.text)
#					$ObjectsOptions.get_child(0).reset_new(2)
#
#			if $ObjectsOptions.get_child(0).dejado == true:
#				$ObjectsOptions.get_child(0).reset_drag_drop()
#
#		if $ObjectsOptions.get_child(1).in_action == true:
#			if $Panel1.get_global_rect().has_point(cursor_pos):
#				print("1")
#				if $ObjectsOptions.get_child(1).agarrado == false and $ObjectsOptions.get_child(1).dejado == true:
#					$ObjectsOptions.get_child(1).set_position_new($Panel1.get_global_rect().position.x, $Panel1.get_global_rect().position.y, $Panel1/MarginContainer/Label.text)
#					$ObjectsOptions.get_child(1).reset_new(1)
#					$Panel1.set_code_obj($ObjectsOptions.get_child(1).code)
#			if $Panel2.get_global_rect().has_point(cursor_pos):
#				print("2")
#				if $ObjectsOptions.get_child(1).agarrado == false and $ObjectsOptions.get_child(1).dejado == true:
#					$ObjectsOptions.get_child(1).set_position_new($Panel2.get_global_rect().position.x, $Panel2.get_global_rect().position.y, $Panel2/MarginContainer/Label.text)
#					$ObjectsOptions.get_child(1).reset_new(2)
#
#			if $ObjectsOptions.get_child(1).agarrado == false and $ObjectsOptions.get_child(1).dejado == true:
#				$ObjectsOptions.get_child(1).reset_drag_drop()
#








#	if $ObjectsOptions.get_child_count() != 0:
#		if $ObjectsOptions.get_child(0).pescado == true:
#			if $Panel1.get_global_rect().has_point(cursor_pos):
#				print("1")
#				if $ObjectsOptions.get_child(0).agarrado == false and $ObjectsOptions.get_child(0).dejado == true:
#					$ObjectsOptions.get_child(0).set_position_new($Panel1.get_global_rect().position.x, $Panel1.get_global_rect().position.y, $Panel1/MarginContainer/Label.text)
#					$ObjectsOptions.get_child(0).reset_new(1)
#					$Panel1.set_code_obj($ObjectsOptions.get_child(0).code)
#			if $Panel2.get_global_rect().has_point(cursor_pos):
#				print("2")
#				if $ObjectsOptions.get_child(0).agarrado == false and $ObjectsOptions.get_child(0).dejado == true:
#					$ObjectsOptions.get_child(0).set_position_new($Panel2.get_global_rect().position.x, $Panel2.get_global_rect().position.y, $Panel2/MarginContainer/Label.text)
#					$ObjectsOptions.get_child(0).reset_new(2)
#
#			if $ObjectsOptions.get_child(0).agarrado == false and $ObjectsOptions.get_child(0).dejado == true:
#				$ObjectsOptions.get_child(0).reset_drag_drop()
#
#		if $ObjectsOptions.get_child(1).pescado == true:
#			if $Panel1.get_global_rect().has_point(cursor_pos):
#				print("1")
#				if $ObjectsOptions.get_child(1).agarrado == false and $ObjectsOptions.get_child(1).dejado == true:
#					$ObjectsOptions.get_child(1).set_position_new($Panel1.get_global_rect().position.x, $Panel1.get_global_rect().position.y, $Panel1/MarginContainer/Label.text)
#					$ObjectsOptions.get_child(1).reset_new(1)
#					$Panel1.set_code_obj($ObjectsOptions.get_child(1).code)
#			if $Panel2.get_global_rect().has_point(cursor_pos):
#				print("2")
#				if $ObjectsOptions.get_child(1).agarrado == false and $ObjectsOptions.get_child(1).dejado == true:
#					$ObjectsOptions.get_child(1).set_position_new($Panel2.get_global_rect().position.x, $Panel2.get_global_rect().position.y, $Panel2/MarginContainer/Label.text)
#					$ObjectsOptions.get_child(1).reset_new(2)
#
#			if $ObjectsOptions.get_child(1).agarrado == false and $ObjectsOptions.get_child(1).dejado == true:
#				$ObjectsOptions.get_child(1).reset_drag_drop()
				
				
				
				
				
				
				
				
				
				
#		if $ObjectsOptions.get_child(0).agarrado == false and $ObjectsOptions.get_child(0).dejado == true and $Panel1.get_global_rect().has_point(cursor_pos):
#			$ObjectsOptions.get_child(0).set_position_new($Panel1.get_global_rect().position.x, $Panel1.get_global_rect().position.y, $Panel1/MarginContainer/Label.text)
#			$ObjectsOptions.get_child(0).reset_new()
#		if $ObjectsOptions.get_child(0).agarrado == false and $ObjectsOptions.get_child(0).dejado == true and !$Panel1.get_global_rect().has_point(cursor_pos):
#			$ObjectsOptions.get_child(0).reset_drag_drop()
#
#		if $ObjectsOptions.get_child(0).agarrado == false and $ObjectsOptions.get_child(0).dejado == true and $Panel2.get_global_rect().has_point(cursor_pos):
#			print("jua")
#			$ObjectsOptions.get_child(0).set_position_new($Panel2.get_global_rect().position.x, $Panel2.get_global_rect().position.y, $Panel2/MarginContainer/Label.text)
#			$ObjectsOptions.get_child(0).reset_new()
#		if $ObjectsOptions.get_child(0).agarrado == false and $ObjectsOptions.get_child(0).dejado == true and !$Panel2.get_global_rect().has_point(cursor_pos):
#			print("jui")
#			$ObjectsOptions.get_child(0).reset_drag_drop()
		
		
#		if $ObjectsOptions.get_child(0).agarrado == false and $ObjectsOptions.get_child(0).dejado == true and $Panel1.get_global_rect().has_point(cursor_pos):
#			print("listo")
#			print($Panel1.get_global_rect().position.x)
#			$ObjectsOptions.get_child(0).set_position_new($Panel1.get_global_rect().position.x, $Panel1.get_global_rect().position.y, $Panel1/MarginContainer/Label.text)
#			$ObjectsOptions.get_child(0).reset_new()
#			#$ObjectsOptions.get_child(0).
#		if $ObjectsOptions.get_child(0).agarrado == false and $ObjectsOptions.get_child(0).dejado == true and !$Panel1.get_global_rect().has_point(cursor_pos):
#			$ObjectsOptions.get_child(0).reset_drag_drop()
		
		
		
		
		#if $ObjectsOptions.get_child(0).agarrado == false and $ObjectsOptions.get_child(0).dejado == true and !$Panel1.get_global_rect().has_point(cursor_pos) and $ObjectsOptions.get_child(0).ocupa_panel == false:
		#	$ObjectsOptions.get_child(0).reset_drag_drop()
#		if $ObjectsOptions.get_child(0).is_inside == true:
#			print("sip")
#		else:
#			print("nop")
#
#	if $Panel.get_global_rect().has_point(cursor_pos):
#		print("chaaaa")
		
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
			obj.set_order_audio($ObjectsSounds.get_child_count()+1)
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
	var card_x = 850
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
				obj.position = Vector2(card_x,330)
				obj.set_start_position(card_x, 330)
				#obj.connect("is_code", self, "_is_code", [obj])
				obj.connect("is_order_and_code", self, "_is_order_and_code", [obj])
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
			correct(x.position.x, x.position.y)
		else:
			incorrect(x.position.x, x.position.y)

func _is_order_and_code(x):
	seleccionado += 1
	if seleccionado == 1:
		var existe = false
		for i in $ObjectsSounds.get_children():
			if x.order_slot != 0 and x.order_slot == i.order_audio:
				if i.code == x.code:
					existe = true
		if existe == true:
			correct(x.position.x, x.position.y)
		else:
			incorrect(x.position.x, x.position.y)
			
func correct(x, y):
	intentos += 1
	score += 1
	$TopPanel.update_score(score)
	print("ok")
	$Timer.start()
	$Correct.visible = true
	$Correct.position = Vector2(x, y)
	$Correct/AnimationPlayer.play("scala")

func incorrect(x, y):
	intentos += 1
	print("no")
	$Timer.start()
	$Incorrect.visible = true
	$Incorrect.position = Vector2(x, y)
	$Incorrect/AnimationPlayer.play("scala")

func next():
	$Timer.stop()
	# Icons
	$Correct.visible = false
	$Incorrect.visible = false
	# Functions
	reset_sounds()
	reset_options()
	# Containers
	$ObjectsOptions.visible = false
	# Vars
	time_left = 2
	seleccionado = 0
	if intentos < 5:
		# Functions
		set_sounds(1)
		set_options(json, 1)
	else:
		if score >= 4:
			audio.stop()
			$PopupFinal.show()
			print("desbloqueado nivel")
		else:
			audio.stop()
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
	$Main/VBox/Margin2/Escuchar.texture_normal = texture_audio_pressed
	audio.play()
	$ObjectsOptions.visible = true
	yield(audio, "finished")
	texture_audio_pressed = load("res://assets/buttons/button-audio-normal-02.png")
	$Main/VBox/Margin2/Escuchar.texture_normal = texture_audio_pressed
	
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
	if score >= 4:
		$PopupFinal.hide()
		$Transition.visible = true
		$Transition/AnimationPlayer.play("fade-in")
		yield($Transition/AnimationPlayer, "animation_finished")
		get_tree().change_scene("res://nivel1-2/Nivel1-2.tscn")
	else:
		$PopupFinal.hide()
		$Transition.visible = true
		$Transition/AnimationPlayer.play("fade-in")
		yield($Transition/AnimationPlayer, "animation_finished")
		get_tree().change_scene("res://nivel1-1/Nivel1-1.tscn")



			
			
			
#func _on_Button_pressed():
#	#pass
#	for i in $ObjectsSounds.get_children():
#		print(i.code, i.orden)
#
#	for i in $ObjectsOptions.get_children():
#		if i.numero_panel != 0:
#			print(i.code, i.numero_panel)
#
#	for i in $ObjectsSounds.get_children():
#		for j in $ObjectsOptions.get_children():
#			if j.numero_panel != 0 and j.numero_panel == i.orden:
#				if j.code == i.code:
#					print("correcto")
#					print(i.code, j.code, i.orden, j.numero_panel)

#	seleccionado += 1
#	if seleccionado == 1:
#		var existe = false
#		for i in $ObjectsSounds.get_children():
#			if i.code == x.code:
#				existe = true
#		if existe == true:
#			correct(x.position.x, x.position.y)
#		else:
#			incorrect(x.position.x, x.position.y)
