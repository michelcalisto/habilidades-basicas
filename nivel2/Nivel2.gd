extends Node2D

var audiobtn = AudioStreamPlayer.new()
var oggbtn = AudioStreamOGGVorbis.new()
export(PackedScene) var Objeto
const objects_file = "res://data/animals.json"
var json
var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var seleccionados = 0
var intentos_level = 0
var level = 1
var score_level = 0
var score_user = 0
var score_total = 0
var time_left = 2
var popup_status = 0
var eleccion_correcta = false
var eleccion_correcta2 = false
var eleccion_correcta3 = false

func _ready():
	var panels_x = 515 - (125 * (2-1))
	$Panels.rect_position.x = panels_x
	# Panels
	$Panels/Margin1.visible = true
	$Panels/Margin2.visible = true
	$Panels/Margin3.visible = false
	$Panels/Margin4.visible = false
	# PopUp
	$PopUp.visible = false
	# Labels
	$TopPanel.update_level(level)
	$TopPanel.update_score(score_total)
	$Main.update_indicaciones_rich("[center]ESCUCHA CON ATENCION [img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"[color=#FFD948]ARRASTRA[/color] LAS IMAGENES SEGUN LO ESCUCHADO\"[/center]")
	
	$Main.update_indicaciones("ESCUCHA CON ATENCION\n\n\"ARRASTRA LAS IMAGENES SEGUN LO ESCUCHADO\"")
	# Transition
	$Transition.visible = true
	$Transition/AnimationPlayer.play("fade-out")
	yield($Transition/AnimationPlayer, "animation_finished")
	$Transition.visible = false
	# Containers
	$Objects.visible = false
	$ObjectsSounds.visible = false
	$ObjectsOptions.visible = false
	# Childs
	add_child(audio)
	# Functions
	json = read_json()
	set_objects(json)
	set_sounds(2)
	_on_Escuchar_pressed()
	set_options(json, 0)
	add_child(audiobtn)
	oggbtn = load("res://assets/sounds/drop_004.ogg")
	oggbtn.loop = false
	audiobtn.stream = oggbtn
	
func _process(delta):
	var cursor_pos = get_global_mouse_position()
	if level == 1 and $ObjectsOptions.get_child_count() != 0:
		var count = 0
		for i in $ObjectsOptions.get_children():
			if $ObjectsOptions.get_child(count).in_action == true:
				if $Panels/Margin1/Panel1.get_global_rect().has_point(cursor_pos) and $Panels/Margin1/Panel1.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panels/Margin1/Panel1.get_global_rect().position.x, $Panels/Margin1/Panel1.get_global_rect().position.y, 1)
						$Panels/Margin1/Panel1.set_slot_item(true)
				elif $Panels/Margin2/Panel2.get_global_rect().has_point(cursor_pos) and $Panels/Margin2/Panel2.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panels/Margin2/Panel2.get_global_rect().position.x, $Panels/Margin2/Panel2.get_global_rect().position.y, 2)
						$Panels/Margin2/Panel2.set_slot_item(true)
				elif $ObjectsOptions.get_child(count).liberado == true:
					$ObjectsOptions.get_child(count).reset_start_position()
			count += 1
	if level == 2 and $ObjectsOptions.get_child_count() != 0:
		var count = 0
		for i in $ObjectsOptions.get_children():
			if $ObjectsOptions.get_child(count).in_action == true:
				if $Panels/Margin1/Panel1.get_global_rect().has_point(cursor_pos) and $Panels/Margin1/Panel1.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panels/Margin1/Panel1.get_global_rect().position.x, $Panels/Margin1/Panel1.get_global_rect().position.y, 1)
						$Panels/Margin1/Panel1.set_slot_item(true)
				elif $Panels/Margin2/Panel2.get_global_rect().has_point(cursor_pos) and $Panels/Margin2/Panel2.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panels/Margin2/Panel2.get_global_rect().position.x, $Panels/Margin2/Panel2.get_global_rect().position.y, 2)
						$Panels/Margin2/Panel2.set_slot_item(true)
				elif $ObjectsOptions.get_child(count).liberado == true:
					$ObjectsOptions.get_child(count).reset_start_position()
			count += 1
	if level == 3 and $ObjectsOptions.get_child_count() != 0:
		var count = 0
		for i in $ObjectsOptions.get_children():
			if $ObjectsOptions.get_child(count).in_action == true:
				if $Panels/Margin1/Panel1.get_global_rect().has_point(cursor_pos) and $Panels/Margin1/Panel1.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panels/Margin1/Panel1.get_global_rect().position.x, $Panels/Margin1/Panel1.get_global_rect().position.y, 1)
						$Panels/Margin1/Panel1.set_slot_item(true)
				elif $Panels/Margin2/Panel2.get_global_rect().has_point(cursor_pos) and $Panels/Margin2/Panel2.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panels/Margin2/Panel2.get_global_rect().position.x, $Panels/Margin2/Panel2.get_global_rect().position.y, 2)
						$Panels/Margin2/Panel2.set_slot_item(true)
				elif $Panels/Margin3/Panel3.get_global_rect().has_point(cursor_pos) and $Panels/Margin3/Panel3.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panels/Margin3/Panel3.get_global_rect().position.x, $Panels/Margin3/Panel3.get_global_rect().position.y, 3)
						$Panels/Margin3/Panel3.set_slot_item(true)
				elif $ObjectsOptions.get_child(count).liberado == true:
					$ObjectsOptions.get_child(count).reset_start_position()
			count += 1
	if level == 4 and $ObjectsOptions.get_child_count() != 0:
		var count = 0
		for i in $ObjectsOptions.get_children():
			if $ObjectsOptions.get_child(count).in_action == true:
				if $Panels/Margin1/Panel1.get_global_rect().has_point(cursor_pos) and $Panels/Margin1/Panel1.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panels/Margin1/Panel1.get_global_rect().position.x, $Panels/Margin1/Panel1.get_global_rect().position.y, 1)
						$Panels/Margin1/Panel1.set_slot_item(true)
				elif $Panels/Margin2/Panel2.get_global_rect().has_point(cursor_pos) and $Panels/Margin2/Panel2.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panels/Margin2/Panel2.get_global_rect().position.x, $Panels/Margin2/Panel2.get_global_rect().position.y, 2)
						$Panels/Margin2/Panel2.set_slot_item(true)
				elif $Panels/Margin3/Panel3.get_global_rect().has_point(cursor_pos) and $Panels/Margin3/Panel3.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panels/Margin3/Panel3.get_global_rect().position.x, $Panels/Margin3/Panel3.get_global_rect().position.y, 3)
						$Panels/Margin3/Panel3.set_slot_item(true)
				elif $Panels/Margin4/Panel4.get_global_rect().has_point(cursor_pos) and $Panels/Margin4/Panel4.contain_slot_item == false:
					if $ObjectsOptions.get_child(count).liberado == true:
						$ObjectsOptions.get_child(count).set_obj_slot($Panels/Margin4/Panel4.get_global_rect().position.x, $Panels/Margin4/Panel4.get_global_rect().position.y, 4)
						$Panels/Margin4/Panel4.set_slot_item(true)
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
			obj.set_order_audio($ObjectsSounds.get_child_count()+1)
			$Objects.remove_child(i)
			$ObjectsSounds.add_child(obj)
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
		
	var card_x = 560 - (100 * (options.size()-1))
	var card_width = 205
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
				obj.position = Vector2(card_x,560)
				obj.set_start_position(card_x, 560)
				obj.connect("is_order_and_code", self, "_is_order_and_code", [obj])
				card_x = card_x + card_width
				$ObjectsOptions.add_child(obj)
		in_list.remove(y)
		options.remove(y)

# Main
func _on_Escuchar_pressed():
	if level == 1 and seleccionados != 2:
		$Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Margin2/Escuchar.disabled = true
		for i in $ObjectsSounds.get_children():
			if seleccionados != 2:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Margin2/Escuchar.disabled = false
		$ObjectsOptions.visible = true
		$Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")
	if level == 2 and seleccionados != 2:
		$Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Margin2/Escuchar.disabled = true
		for i in $ObjectsSounds.get_children():
			if seleccionados != 2:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Margin2/Escuchar.disabled = false
		$ObjectsOptions.visible = true
		$Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")
	if level == 3 and seleccionados != 3:
		$Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Margin2/Escuchar.disabled = true
		for i in $ObjectsSounds.get_children():
			if seleccionados != 3:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Margin2/Escuchar.disabled = false
		$ObjectsOptions.visible = true
		$Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")
	if level == 4 and seleccionados != 4:
		$Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Margin2/Escuchar.disabled = true
		for i in $ObjectsSounds.get_children():
			if seleccionados != 4:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Margin2/Escuchar.disabled = false
		$ObjectsOptions.visible = true
		$Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")

# Funcion que se ejecuta al soltar un elemento sobre un slot
func _is_order_and_code(x):
	if level == 1:
		if seleccionados == 0:
			seleccionados += 1
			var existe = false
			for i in $ObjectsSounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				eleccion_correcta = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionados == 1:
			seleccionados += 1
			intentos_level += 1
			audio.stop()
			var existe = false
			for i in $ObjectsSounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)
	if level == 2:
		if seleccionados == 0:
			seleccionados += 1
			var existe = false
			for i in $ObjectsSounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				eleccion_correcta = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionados == 1:
			seleccionados += 1
			intentos_level += 1
			audio.stop()
			var existe = false
			for i in $ObjectsSounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)
	if level == 3:
		if seleccionados == 0:
			seleccionados += 1
			var existe = false
			for i in $ObjectsSounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				eleccion_correcta = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionados == 1:
			seleccionados += 1
			var existe = false
			for i in $ObjectsSounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				eleccion_correcta2 = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionados == 2:
			seleccionados += 1
			intentos_level += 1
			audio.stop()
			var existe = false
			for i in $ObjectsSounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)
	if level == 4:
		if seleccionados == 0:
			seleccionados += 1
			var existe = false
			for i in $ObjectsSounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				eleccion_correcta = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionados == 1:
			seleccionados += 1
			var existe = false
			for i in $ObjectsSounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				eleccion_correcta2 = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionados == 2:
			seleccionados += 1
			var existe = false
			for i in $ObjectsSounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				eleccion_correcta3 = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionados == 3:
			seleccionados += 1
			intentos_level += 1
			audio.stop()
			var existe = false
			for i in $ObjectsSounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)

func correct(x):
	if level == 1:
		if seleccionados == 1:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 2:
			if eleccion_correcta == true:
				score_level += 1
				score_total += 1
			$TopPanel.update_score(score_total)
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
			$Timer.start()
	if level == 2:
		if seleccionados == 1:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 2:
			if eleccion_correcta == true:
				score_level += 1
				score_total += 1
			$TopPanel.update_score(score_total)
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
			$Timer.start()
	if level == 3:
		if seleccionados == 1:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 2:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 3:
			if eleccion_correcta == true and eleccion_correcta2 == true:
				score_level += 1
				score_total += 1
			$TopPanel.update_score(score_total)
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
			$Timer.start()
	if level == 4:
		if seleccionados == 1:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 2:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 3:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 4:
			if eleccion_correcta == true and eleccion_correcta2 == true and eleccion_correcta3 == true:
				score_level += 1
				score_total += 1
			$TopPanel.update_score(score_total)
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
			$Timer.start()
	
func incorrect(x):
	if level == 1:
		if seleccionados == 1:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
		elif seleccionados == 2:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
			$Timer.start()
	if level == 2:
		if seleccionados == 1:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
		elif seleccionados == 2:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
			$Timer.start()
	if level == 3:
		if seleccionados == 1:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
		elif seleccionados == 2:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
		elif seleccionados == 3:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
			$Timer.start()
	if level == 4:
		if seleccionados == 1:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
		elif seleccionados == 2:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
		elif seleccionados == 3:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
		elif seleccionados == 4:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
			$Timer.start()

# Timer
func _on_Timer_timeout():
	time_left -=1
	if time_left <= 0:
		if intentos_level <= 2:
			next()
		else:
			$TopPanel/Margin1/ToMenu.disabled = false
			$PopUp.visible = false
			$PopUp.reset_nextlevel()
			next_level(score_level, score_total, level+1)

func next():
	# Timer
	$Timer.stop()
	# Containers
	$ObjectsOptions.visible = false
	# Vars
	time_left = 2
	seleccionados = 0
	# Functions
	reset_containers()
	# Nivel 2
	eleccion_correcta = false
	eleccion_correcta2 = false
	eleccion_correcta3 = false
	if level == 1:
		$Panels/Margin1/Panel1.set_slot_item(false)
		$Panels/Margin2/Panel2.set_slot_item(false)
	if level == 2:
		$Panels/Margin1/Panel1.set_slot_item(false)
		$Panels/Margin2/Panel2.set_slot_item(false)
	if level == 3:
		$Panels/Margin1/Panel1.set_slot_item(false)
		$Panels/Margin2/Panel2.set_slot_item(false)
		$Panels/Margin3/Panel3.set_slot_item(false)
	if level == 4:
		$Panels/Margin1/Panel1.set_slot_item(false)
		$Panels/Margin2/Panel2.set_slot_item(false)
		$Panels/Margin3/Panel3.set_slot_item(false)
		$Panels/Margin4/Panel4.set_slot_item(false)
	if intentos_level < 2:
		if level == 1:
			set_sounds(2)
			_on_Escuchar_pressed()
			set_options(json, 0)
		if level == 2:
			set_sounds(2)
			_on_Escuchar_pressed()
			set_options(json, 1)
		if level == 3:
			set_sounds(3)
			_on_Escuchar_pressed()
			set_options(json, 0)
		if level == 4:
			set_sounds(4)
			_on_Escuchar_pressed()
			set_options(json, 0)
	else:
		if score_level == 2:
			if level == 4:
				popup_status = 1
				$Particles2D.emitting = true
				#$PopUp.update_info_rich("[center]FELICITACIONES HAS COMPLETADO\nTODOS LOS NIVELES\nPUNTAJE FINAL : "+str(score_total)+" DE 8 PUNTOS\n[img=50x50]res://assets/emojis/win-1.png[/img][img=50x50]res://assets/emojis/win-2.png[/img][img=50x50]res://assets/emojis/win-3.png[/img][/center]")
				$PopUp.update_info_rich("[center]FELICITACIONES HAS COMPLETADO\nTODOS LOS NIVELES\nPUNTAJE FINAL : "+str(score_total)+" DE 8 PUNTOS[/center]")
				$PopUp/VBox/Margin.rect_min_size.y = 90
				$PopUp/VBox/Margin3.visible = true
			
				$PopUp.update_info("FELICITACIONES HAS COMPLETADO\nTODOS LOS NIVELES\n\nPUNTAJE FINAL : "+str(score_total)+" DE 8 PUNTOS")
				$TopPanel/Margin1/ToMenu.disabled = true
				$PopUp.update_textures_aceptar("res://assets/buttons/nivels/finalizarbasic.png","res://assets/buttons/nivels/finalizarpress.png")
				$PopUp.set_final()
				$Margin2/Escuchar.visible = false
				$PopUp.visible = true
			else:
				intentos_level += 1
				$Timer.start()
				$PopUp.update_info_rich("[center]FELICITACIONES SIGUE AVANZANDO\n\n[img=50x50]res://assets/emojis/nivel1.png[/img][img=50x50]res://assets/emojis/nivel2.png[/img][/center]")
	
				$PopUp.update_info("FELICITACIONES SIGUE AVANZANDO")
				$TopPanel/Margin1/ToMenu.disabled = true
				$PopUp.set_nextlevel()
				$Margin2/Escuchar.visible = false
				$PopUp.visible = true
		else:
			popup_status = 2
			$PopUp.update_info_rich("[center]HAS OBTENIDO : "+str(score_total)+" DE 8 PUNTOS\nSIGUELO INTENTANDO\n\n[img=50x50]res://assets/emojis/loser1.png[/img][img=50x50]res://assets/emojis/loser2.png[/img][/center]")
	
			$PopUp.update_info("HAS OBTENIDO : "+str(score_total)+" DE 8 PUNTOS\nSIGUELO INTENTANDO")
			$TopPanel/Margin1/ToMenu.disabled = true
			$PopUp.update_textures_aceptar("res://assets/buttons/nivels/reintentarbasic.png","res://assets/buttons/nivels/reintentarpress.png")
			$PopUp.update_textures_rechazar("res://assets/buttons/nivels/finalizarbasic.png","res://assets/buttons/nivels/finalizarpress.png")
			$Margin2/Escuchar.visible = false
			$PopUp.visible = true

func reset_containers():
	for i in $ObjectsSounds.get_children():
		$ObjectsSounds.remove_child(i)
	for i in $ObjectsOptions.get_children():
		$ObjectsOptions.remove_child(i)

# TopPanel
func _on_ToMenu_pressed():
	audiobtn.play()
	popup_status = 1
	$PopUp.update_info_rich("[center]RECUERDA QUE AL REGRESAR AL\nMENU PRINCIPAL PERDERAS TU\nPROGRESO[/center]")
	
	$PopUp.update_info("RECUERDA QUE AL REGRESAR AL\nMENU PRINCIPAL PERDERAS TU\nPROGRESO")
	$PopUp.update_textures_aceptar("res://assets/buttons/nivels/sibasic.png","res://assets/buttons/nivels/sipress.png")
	$PopUp.update_textures_rechazar("res://assets/buttons/nivels/nobasic.png","res://assets/buttons/nivels/nopress.png")
	$PopUp.visible = true

# PopUp
func _on_Aceptar_pressed():
	audiobtn.play()
	if popup_status == 1:
		$PopUp.visible = false
		$Transition.visible = true
		$Transition/AnimationPlayer.play("fade-in")
		yield($Transition/AnimationPlayer, "animation_finished")
		get_tree().change_scene("res://titlescreen/TitleScreen.tscn")
	if popup_status == 2:
		reintentar()
		$TopPanel/Margin1/ToMenu.disabled = false
		$Margin2/Escuchar.visible = true
		$PopUp.visible = false

func _on_Rechazar_pressed():
	audiobtn.play()
	if popup_status == 1:
		$PopUp.visible = false
	if popup_status == 2:
		$PopUp.visible = false
		$Transition.visible = true
		$Transition/AnimationPlayer.play("fade-in")
		yield($Transition/AnimationPlayer, "animation_finished")
		get_tree().change_scene("res://titlescreen/TitleScreen.tscn")

func next_level(s,t,l):
	if l == 2:
		var panels_x = 515 - (125 * (2-1))
		$Panels.rect_position.x = panels_x
		# Panels
		$Panels/Margin1.visible = true
		$Panels/Margin2.visible = true
		$Panels/Margin3.visible = false
		$Panels/Margin4.visible = false
		$Main.update_indicaciones_rich("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"[color=#FFD948]ARRASTRA[/color] LAS IMAGENES SEGUN LO ESCUCHADO\"[/center]")
	
		$Main.update_indicaciones("\n\n\"ARRASTRA LAS IMAGENES SEGUN LO ESCUCHADO\"")
	if l == 3:
		var panels_x = 515 - (125 * (3-1))
		$Panels.rect_position.x = panels_x
		# Panels
		$Panels/Margin1.visible = true
		$Panels/Margin2.visible = true
		$Panels/Margin3.visible = true
		$Panels/Margin4.visible = false
		$Main.update_indicaciones_rich("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"[color=#FFD948]ARRASTRA[/color] LAS IMAGENES SEGUN LO ESCUCHADO\"[/center]")
	
		$Main.update_indicaciones("\n\n\"ARRASTRA LAS IMAGENES SEGUN LO ESCUCHADO\"")
	if l == 4:
		var panels_x = 515 - (125 * (4-1))
		$Panels.rect_position.x = panels_x
		# Panels
		$Panels/Margin1.visible = true
		$Panels/Margin2.visible = true
		$Panels/Margin3.visible = true
		$Panels/Margin4.visible = true
		$Main.update_indicaciones_rich("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"[color=#FFD948]ARRASTRA[/color] LAS IMAGENES SEGUN LO ESCUCHADO\"[/center]")
	
		$Main.update_indicaciones("\n\n\"ARRASTRA LAS IMAGENES SEGUN LO ESCUCHADO\"")
	$Margin2/Escuchar.visible = true
	# Timer
	$Timer.stop()
	# Containers
	$ObjectsOptions.visible = false
	# Vars
	seleccionados = 0
	intentos_level = 0
	level = l
	score_level = 0
	score_user = t
	score_total = score_user
	time_left = 2
	#popup_status = 0
	eleccion_correcta = false
	eleccion_correcta2 = false
	eleccion_correcta3 = false
	# Functions
	reset_containers()
	$TopPanel.update_level(level)
	json = read_json()
	set_objects(json)
	if level == 2:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 1)
	if level == 3:
		set_sounds(3)
		_on_Escuchar_pressed()
		set_options(json, 0)
	if level == 4:
		set_sounds(4)
		_on_Escuchar_pressed()
		set_options(json, 0)

func reintentar():
	$TopPanel.update_score(score_user)
	$Margin2/Escuchar.visible = true
	# Timer
	$Timer.stop()
	# Containers
	$ObjectsOptions.visible = false
	# Vars
	seleccionados = 0
	intentos_level = 0
	#level = 1
	score_level = 0
	#score_user = 0
	score_total = score_user
	time_left = 2
	#popup_status = 0
	eleccion_correcta = false
	eleccion_correcta2 = false
	eleccion_correcta3 = false
	# Functions
	reset_containers()
	json = read_json()
	set_objects(json)
	if level == 1:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 0)
	if level == 2:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 1)
	if level == 3:
		set_sounds(3)
		_on_Escuchar_pressed()
		set_options(json, 0)
	if level == 4:
		set_sounds(4)
		_on_Escuchar_pressed()
		set_options(json, 0)
