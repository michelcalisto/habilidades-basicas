extends Node2D

export(PackedScene) var Objeto
const objects_file = "res://data/animals.json"
var json
var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var seleccionados = 0
var intentos_level = 0
var score_level = 0
var score_total = 0
var time_left = 2
var eleccion_correcta1 = false
var eleccion_correcta2 = false
var eleccion_correcta3 = false

func _ready():
	# HUD
	$HUD.update_level(Global.nivels_level)
	$HUD.update_score(Global.nivels_score)
	score_total = Global.nivels_score
	# Panels
	if Global.nivels_level == 1:
		update_indicaciones("[center]ESCUCHA CON ATENCION [img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"[color=#FFD948]ARRASTRA[/color] LAS IMAGENES SEGUN LO ESCUCHADO\"[/center]")
		var panels_x = 515 - (125 * (2-1))
		$Panels.rect_position.x = panels_x
		$Panels/Margin1.visible = true
		$Panels/Margin2.visible = true
	if Global.nivels_level == 2:
		update_indicaciones("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"[color=#FFD948]ARRASTRA[/color] LAS IMAGENES SEGUN LO ESCUCHADO\"[/center]")
		var panels_x = 515 - (125 * (2-1))
		$Panels.rect_position.x = panels_x
		# Panels
		$Panels/Margin1.visible = true
		$Panels/Margin2.visible = true
	if Global.nivels_level == 3:
		update_indicaciones("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"[color=#FFD948]ARRASTRA[/color] LAS IMAGENES SEGUN LO ESCUCHADO\"[/center]")
		var panels_x = 515 - (125 * (3-1))
		$Panels.rect_position.x = panels_x
		# Panels
		$Panels/Margin1.visible = true
		$Panels/Margin2.visible = true
		$Panels/Margin3.visible = true
	if Global.nivels_level == 4:
		update_indicaciones("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"[color=#FFD948]ARRASTRA[/color] LAS IMAGENES SEGUN LO ESCUCHADO\"[/center]")
		var panels_x = 515 - (125 * (4-1))
		$Panels.rect_position.x = panels_x
		# Panels
		$Panels/Margin1.visible = true
		$Panels/Margin2.visible = true
		$Panels/Margin3.visible = true
		$Panels/Margin4.visible = true
	# Transition
	$Transition.fadeOut()
	yield($Transition/AnimationPlayer, "animation_finished")
	# Childs
	add_child(audio)
	# Functions
	json = read_json()
	set_objects(json)
	if Global.nivels_level == 1:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 0)
	if Global.nivels_level == 2:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 1)
	if Global.nivels_level == 3:
		set_sounds(3)
		_on_Escuchar_pressed()
		set_options(json, 0)
	if Global.nivels_level == 4:
		set_sounds(4)
		_on_Escuchar_pressed()
		set_options(json, 0)

func update_indicaciones(x):
	$Display/Margin1/Indicaciones.clear()
	$Display/Margin1/Indicaciones.append_bbcode(str(x))

func _process(delta):
	var cursor_pos = get_global_mouse_position()
	if Global.nivels_level == 1 and $Options.get_child_count() != 0:
		var count = 0
		for i in $Options.get_children():
			if $Options.get_child(count).in_action == true:
				if $Panels/Margin1/Panel1.get_global_rect().has_point(cursor_pos) and $Panels/Margin1/Panel1.contain_slot_item == false:
					if $Options.get_child(count).liberado == true:
						$Options.get_child(count).set_obj_slot($Panels/Margin1/Panel1.get_global_rect().position.x, $Panels/Margin1/Panel1.get_global_rect().position.y, 1)
						$Panels/Margin1/Panel1.set_slot_item(true)
				elif $Panels/Margin2/Panel2.get_global_rect().has_point(cursor_pos) and $Panels/Margin2/Panel2.contain_slot_item == false:
					if $Options.get_child(count).liberado == true:
						$Options.get_child(count).set_obj_slot($Panels/Margin2/Panel2.get_global_rect().position.x, $Panels/Margin2/Panel2.get_global_rect().position.y, 2)
						$Panels/Margin2/Panel2.set_slot_item(true)
				elif $Options.get_child(count).liberado == true:
					$Options.get_child(count).reset_start_position()
			count += 1
	if Global.nivels_level == 2 and $Options.get_child_count() != 0:
		var count = 0
		for i in $Options.get_children():
			if $Options.get_child(count).in_action == true:
				if $Panels/Margin1/Panel1.get_global_rect().has_point(cursor_pos) and $Panels/Margin1/Panel1.contain_slot_item == false:
					if $Options.get_child(count).liberado == true:
						$Options.get_child(count).set_obj_slot($Panels/Margin1/Panel1.get_global_rect().position.x, $Panels/Margin1/Panel1.get_global_rect().position.y, 1)
						$Panels/Margin1/Panel1.set_slot_item(true)
				elif $Panels/Margin2/Panel2.get_global_rect().has_point(cursor_pos) and $Panels/Margin2/Panel2.contain_slot_item == false:
					if $Options.get_child(count).liberado == true:
						$Options.get_child(count).set_obj_slot($Panels/Margin2/Panel2.get_global_rect().position.x, $Panels/Margin2/Panel2.get_global_rect().position.y, 2)
						$Panels/Margin2/Panel2.set_slot_item(true)
				elif $Options.get_child(count).liberado == true:
					$Options.get_child(count).reset_start_position()
			count += 1
	if Global.nivels_level == 3 and $Options.get_child_count() != 0:
		var count = 0
		for i in $Options.get_children():
			if $Options.get_child(count).in_action == true:
				if $Panels/Margin1/Panel1.get_global_rect().has_point(cursor_pos) and $Panels/Margin1/Panel1.contain_slot_item == false:
					if $Options.get_child(count).liberado == true:
						$Options.get_child(count).set_obj_slot($Panels/Margin1/Panel1.get_global_rect().position.x, $Panels/Margin1/Panel1.get_global_rect().position.y, 1)
						$Panels/Margin1/Panel1.set_slot_item(true)
				elif $Panels/Margin2/Panel2.get_global_rect().has_point(cursor_pos) and $Panels/Margin2/Panel2.contain_slot_item == false:
					if $Options.get_child(count).liberado == true:
						$Options.get_child(count).set_obj_slot($Panels/Margin2/Panel2.get_global_rect().position.x, $Panels/Margin2/Panel2.get_global_rect().position.y, 2)
						$Panels/Margin2/Panel2.set_slot_item(true)
				elif $Panels/Margin3/Panel3.get_global_rect().has_point(cursor_pos) and $Panels/Margin3/Panel3.contain_slot_item == false:
					if $Options.get_child(count).liberado == true:
						$Options.get_child(count).set_obj_slot($Panels/Margin3/Panel3.get_global_rect().position.x, $Panels/Margin3/Panel3.get_global_rect().position.y, 3)
						$Panels/Margin3/Panel3.set_slot_item(true)
				elif $Options.get_child(count).liberado == true:
					$Options.get_child(count).reset_start_position()
			count += 1
	if Global.nivels_level == 4 and $Options.get_child_count() != 0:
		var count = 0
		for i in $Options.get_children():
			if $Options.get_child(count).in_action == true:
				if $Panels/Margin1/Panel1.get_global_rect().has_point(cursor_pos) and $Panels/Margin1/Panel1.contain_slot_item == false:
					if $Options.get_child(count).liberado == true:
						$Options.get_child(count).set_obj_slot($Panels/Margin1/Panel1.get_global_rect().position.x, $Panels/Margin1/Panel1.get_global_rect().position.y, 1)
						$Panels/Margin1/Panel1.set_slot_item(true)
				elif $Panels/Margin2/Panel2.get_global_rect().has_point(cursor_pos) and $Panels/Margin2/Panel2.contain_slot_item == false:
					if $Options.get_child(count).liberado == true:
						$Options.get_child(count).set_obj_slot($Panels/Margin2/Panel2.get_global_rect().position.x, $Panels/Margin2/Panel2.get_global_rect().position.y, 2)
						$Panels/Margin2/Panel2.set_slot_item(true)
				elif $Panels/Margin3/Panel3.get_global_rect().has_point(cursor_pos) and $Panels/Margin3/Panel3.contain_slot_item == false:
					if $Options.get_child(count).liberado == true:
						$Options.get_child(count).set_obj_slot($Panels/Margin3/Panel3.get_global_rect().position.x, $Panels/Margin3/Panel3.get_global_rect().position.y, 3)
						$Panels/Margin3/Panel3.set_slot_item(true)
				elif $Panels/Margin4/Panel4.get_global_rect().has_point(cursor_pos) and $Panels/Margin4/Panel4.contain_slot_item == false:
					if $Options.get_child(count).liberado == true:
						$Options.get_child(count).set_obj_slot($Panels/Margin4/Panel4.get_global_rect().position.x, $Panels/Margin4/Panel4.get_global_rect().position.y, 4)
						$Panels/Margin4/Panel4.set_slot_item(true)
				elif $Options.get_child(count).liberado == true:
					$Options.get_child(count).reset_start_position()
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
			obj.set_order_audio($Sounds.get_child_count()+1)
			$Objects.remove_child(i)
			$Sounds.add_child(obj)
		else:
			count += 1

func set_options(x, agregar):
	# Distribucion de los objetos
	var all = Array()
	var options = Array()
	for i in x:
		var existe = false
		for j in $Sounds.get_children():
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
				$Options.add_child(obj)
		in_list.remove(y)
		options.remove(y)

func _on_Escuchar_pressed():
	if Global.nivels_level == 1 and seleccionados != 2:
		$Margin/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Margin/Escuchar.disabled = true
		for i in $Sounds.get_children():
			if seleccionados != 2:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Margin/Escuchar.disabled = false
		$Panels.visible = true
		$Options.visible = true
		$Margin/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")
	if Global.nivels_level == 2 and seleccionados != 2:
		$Margin/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Margin/Escuchar.disabled = true
		for i in $Sounds.get_children():
			if seleccionados != 2:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Margin/Escuchar.disabled = false
		$Panels.visible = true
		$Options.visible = true
		$Margin/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")
	if Global.nivels_level == 3 and seleccionados != 3:
		$Margin/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Margin/Escuchar.disabled = true
		for i in $Sounds.get_children():
			if seleccionados != 3:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Margin/Escuchar.disabled = false
		$Panels.visible = true
		$Options.visible = true
		$Margin/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")
	if Global.nivels_level == 4 and seleccionados != 4:
		$Margin/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Margin/Escuchar.disabled = true
		for i in $Sounds.get_children():
			if seleccionados != 4:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Margin/Escuchar.disabled = false
		$Panels.visible = true
		$Options.visible = true
		$Margin/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")

# Funcion que se ejecuta al soltar un elemento sobre un slot
func _is_order_and_code(x):
	if Global.nivels_level == 1:
		if seleccionados == 0:
			seleccionados += 1
			var existe = false
			for i in $Sounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				eleccion_correcta1 = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionados == 1:
			seleccionados += 1
			intentos_level += 1
			audio.stop()
			var existe = false
			for i in $Sounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)
	if Global.nivels_level == 2:
		if seleccionados == 0:
			seleccionados += 1
			var existe = false
			for i in $Sounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				eleccion_correcta1 = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionados == 1:
			seleccionados += 1
			intentos_level += 1
			audio.stop()
			var existe = false
			for i in $Sounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)
	if Global.nivels_level == 3:
		if seleccionados == 0:
			seleccionados += 1
			var existe = false
			for i in $Sounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				eleccion_correcta1 = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionados == 1:
			seleccionados += 1
			var existe = false
			for i in $Sounds.get_children():
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
			for i in $Sounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)
	if Global.nivels_level == 4:
		if seleccionados == 0:
			seleccionados += 1
			var existe = false
			for i in $Sounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				eleccion_correcta1 = true
				correct(x)
			else:
				incorrect(x)
		elif seleccionados == 1:
			seleccionados += 1
			var existe = false
			for i in $Sounds.get_children():
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
			for i in $Sounds.get_children():
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
			for i in $Sounds.get_children():
				if x.order_slot != 0 and x.order_slot == i.order_audio:
					if i.code == x.code:
						existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)

func correct(x):
	if Global.nivels_level == 1:
		if seleccionados == 1:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 2:
			if eleccion_correcta1 == true:
				score_level += 1
				score_total += 1
			$HUD.update_score(score_total)
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
			$Timer.start()
	if Global.nivels_level == 2:
		if seleccionados == 1:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 2:
			if eleccion_correcta1 == true:
				score_level += 1
				score_total += 1
			$HUD.update_score(score_total)
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
			$Timer.start()
	if Global.nivels_level == 3:
		if seleccionados == 1:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 2:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 3:
			if eleccion_correcta1 == true and eleccion_correcta2 == true:
				score_level += 1
				score_total += 1
			$HUD.update_score(score_total)
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
			$Timer.start()
	if Global.nivels_level == 4:
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
			if eleccion_correcta1 == true and eleccion_correcta2 == true and eleccion_correcta3 == true:
				score_level += 1
				score_total += 1
			$HUD.update_score(score_total)
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
			$Timer.start()
	
func incorrect(x):
	if Global.nivels_level == 1:
		if seleccionados == 1:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
		elif seleccionados == 2:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
			$Timer.start()
	if Global.nivels_level == 2:
		if seleccionados == 1:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
		elif seleccionados == 2:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
			$Timer.start()
	if Global.nivels_level == 3:
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
	if Global.nivels_level == 4:
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

func _on_Timer_timeout():
	time_left -=1
	if time_left <= 0:
		if intentos_level <= 2:
			next()
		else:
			$HUD.reset_popup_info()
			next_level(score_level, score_total, Global.nivels_level+1)

func reset_containers():
	for i in $Sounds.get_children():
		$Sounds.remove_child(i)
	for i in $Options.get_children():
		$Options.remove_child(i)

func next():
	# Timer
	$Timer.stop()
	# Containers
	$Panels.visible = false
	$Options.visible = false
	# Vars
	time_left = 2
	seleccionados = 0	
	# Functions
	reset_containers()
	eleccion_correcta1 = false
	eleccion_correcta2 = false
	eleccion_correcta3 = false
	
	if Global.nivels_level == 1:
		$Panels/Margin1/Panel1.set_slot_item(false)
		$Panels/Margin2/Panel2.set_slot_item(false)
	if Global.nivels_level == 2:
		$Panels/Margin1/Panel1.set_slot_item(false)
		$Panels/Margin2/Panel2.set_slot_item(false)
	if Global.nivels_level == 3:
		$Panels/Margin1/Panel1.set_slot_item(false)
		$Panels/Margin2/Panel2.set_slot_item(false)
		$Panels/Margin3/Panel3.set_slot_item(false)
	if Global.nivels_level == 4:
		$Panels/Margin1/Panel1.set_slot_item(false)
		$Panels/Margin2/Panel2.set_slot_item(false)
		$Panels/Margin3/Panel3.set_slot_item(false)
		$Panels/Margin4/Panel4.set_slot_item(false)
	if intentos_level < 2:
		if Global.nivels_level == 1:
			set_sounds(2)
			_on_Escuchar_pressed()
			set_options(json, 0)
		if Global.nivels_level == 2:
			set_sounds(2)
			_on_Escuchar_pressed()
			set_options(json, 1)
		if Global.nivels_level == 3:
			set_sounds(3)
			_on_Escuchar_pressed()
			set_options(json, 0)
		if Global.nivels_level == 4:
			set_sounds(4)
			_on_Escuchar_pressed()
			set_options(json, 0)
	else:
		if score_level == 2:
			if Global.nivels_level == 4:
				$Margin/Escuchar.visible = false
				$HUD.show_popup_finalizar("[center]¡FELICITACIONES!\nPUNTAJE FINAL : "+str(score_total)+" DE 8 PUNTOS\n\n[img=50x50]res://assets/emojis/win1.png[/img][img=50x50]res://assets/emojis/win2.png[/img][img=50x50]res://assets/emojis/win3.png[/img][/center]")
			else:
				intentos_level += 1
				$Timer.start()
				$Margin/Escuchar.visible = false
				$HUD.show_popup_info()
		else:
			$Margin/Escuchar.visible = false
			$HUD.show_popup_reintentar("[center]HAS OBTENIDO : "+str(score_total)+" DE 8 PUNTOS\nSIGUELO INTENTANDO\n\n[img=50x50]res://assets/emojis/loser1.png[/img][img=50x50]res://assets/emojis/loser2.png[/img][/center]")

func next_level(s,t,l):
	if l == 2:
		# Panels
		var panels_x = 515 - (125 * (2-1))
		$Panels.rect_position.x = panels_x
		$Panels/Margin1.visible = true
		$Panels/Margin2.visible = true
		# Display
		update_indicaciones("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"[color=#FFD948]ARRASTRA[/color] LAS IMAGENES SEGUN LO ESCUCHADO\"[/center]")
	if l == 3:
		# Panels
		var panels_x = 515 - (125 * (3-1))
		$Panels.rect_position.x = panels_x
		$Panels/Margin1.visible = true
		$Panels/Margin2.visible = true
		$Panels/Margin3.visible = true
		# Display
		update_indicaciones("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"[color=#FFD948]ARRASTRA[/color] LAS IMAGENES SEGUN LO ESCUCHADO\"[/center]")
	if l == 4:
		# Panels
		var panels_x = 515 - (125 * (4-1))
		$Panels.rect_position.x = panels_x
		$Panels/Margin1.visible = true
		$Panels/Margin2.visible = true
		$Panels/Margin3.visible = true
		$Panels/Margin4.visible = true
		# Display
		update_indicaciones("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"[color=#FFD948]ARRASTRA[/color] LAS IMAGENES SEGUN LO ESCUCHADO\"[/center]")
	$Margin/Escuchar.visible = true
	# Timer
	$Timer.stop()
	# Containers
	$Options.visible = false
	# Vars
	seleccionados = 0
	intentos_level = 0
	Global.update_level(l)
	score_level = 0
	Global.update_score(t)
	score_total = Global.nivels_score
	time_left = 2
	eleccion_correcta1 = false
	eleccion_correcta2 = false
	eleccion_correcta3 = false
	# Functions
	reset_containers()
	$HUD.update_level(Global.nivels_level)
	json = read_json()
	set_objects(json)
	if Global.nivels_level == 2:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 1)
	if Global.nivels_level == 3:
		set_sounds(3)
		_on_Escuchar_pressed()
		set_options(json, 0)
	if Global.nivels_level == 4:
		set_sounds(4)
		_on_Escuchar_pressed()
		set_options(json, 0)
