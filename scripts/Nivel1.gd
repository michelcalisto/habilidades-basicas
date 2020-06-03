extends Node2D

export(PackedScene) var Objeto
const objects_file = "res://data/animals.json"
var json
var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var seleccionados = 0
var intentos_level = 0
#var level = 1
var score_level = 0
#var score_user = 0
var score_total = 0
var time_left = 2
var eleccion_correcta = false

func _ready():
	# HUD
	$HUD.update_level(Global.nivel1_level)
	$HUD.update_score(Global.nivel1_score)
	# Display
	if Global.nivel1_level == 1:
		update_indicaciones("[center]¡ESCUCHA CON ATENCION! [img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"PRESIONA [color=#FFD948]EL[/color] ANIMAL ESCUCHADO\"[/center]")
	if Global.nivel1_level == 2:
		update_indicaciones("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"PRESIONA [color=#FFD948]LOS[/color] ANIMALES QUE ESCUCHES\"[/center]")
	if Global.nivel1_level == 3:
		update_indicaciones("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"PRESIONA [color=#FFD948]EL[/color] ANIMAL [color=#FFD948]NO[/color] ESCUCHADO\"[/center]")
	# Transition
	$Transition.fadeOut()
	yield($Transition/AnimationPlayer, "animation_finished")
	# Childs
	add_child(audio)
	# Functions
	json = read_json()
	set_objects(json)
	if Global.nivel1_level == 1:
		set_sounds(1)
		_on_Escuchar_pressed()
		set_options(json, 1)
	if Global.nivel1_level == 2:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 1)
	if Global.nivel1_level == 3:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 1)

func update_indicaciones(x):
	$Display/Margin1/Indicaciones.clear()
	$Display/Margin1/Indicaciones.append_bbcode(str(x))

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
	
	var card_x = 640 - ((100 + 25) * (options.size()-1))
	var card_width = 200 + 50
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
				obj.connect("is_code", self, "_is_code", [obj])
				card_x = card_x + card_width
				$Options.add_child(obj)
		in_list.remove(y)
		options.remove(y)

# Escuchar
func _on_Escuchar_pressed():
	if Global.nivel1_level == 1 and seleccionados != 1:
		$Display/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Display/Margin2/Escuchar.disabled = true
		for i in $Sounds.get_children():
			if seleccionados != 1:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Display/Margin2/Escuchar.disabled = false
		$Options.visible = true
		$Display/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")
	if Global.nivel1_level == 2 and seleccionados != 2:
		$Display/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Display/Margin2/Escuchar.disabled = true
		for i in $Sounds.get_children():
			if seleccionados != 2:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Display/Margin2/Escuchar.disabled = false
		$Options.visible = true
		$Display/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")
	if Global.nivel1_level == 3 and seleccionados != 1:
		$Display/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Display/Margin2/Escuchar.disabled = true
		for i in $Sounds.get_children():
			if seleccionados != 1:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Display/Margin2/Escuchar.disabled = false
		$Options.visible = true
		$Display/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")


# Funcion que se ejecuta al clickear en un objeto
func _is_code(x):
	if Global.nivel1_level == 1 and seleccionados == 0:
		seleccionados += 1
		intentos_level += 1
		audio.stop()
		var existe = false
		for i in $Sounds.get_children():
			if i.code == x.code:
				existe = true
		if existe == true:
			correct(x)
		else:
			incorrect(x)
	if Global.nivel1_level == 2:
		if seleccionados == 0:
			seleccionados += 1
			var existe = false
			for i in $Sounds.get_children():
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
			for i in $Sounds.get_children():
				if i.code == x.code:
					existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)
	if Global.nivel1_level == 3 and seleccionados == 0:
		seleccionados += 1
		intentos_level += 1
		audio.stop()
		var existe = false
		for i in $Sounds.get_children():
			if i.code == x.code:
				existe = true
		if existe == true:
			incorrect(x)
		else:
			correct(x)

func correct(x):
	if Global.nivel1_level == 1:
		score_level += 1
		score_total += 1
		$HUD.update_score(score_total)
		#$TopPanel.update_score(score_total)
		x.set_status("res://assets/icons/correct.png")
		x.set_sound_victory()
		$Timer.start()
	if Global.nivel1_level == 2:
		if seleccionados == 1:
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
		elif seleccionados == 2:
			if eleccion_correcta == true:
				score_level += 1
				score_total += 1
			$HUD.update_score(score_total)
			#$TopPanel.update_score(score_total)
			x.set_status("res://assets/icons/correct.png")
			x.set_sound_victory()
			$Timer.start()
	if Global.nivel1_level == 3:
		score_level += 1
		score_total += 1
		$HUD.update_score(score_total)
		#$TopPanel.update_score(score_total)
		x.set_status("res://assets/icons/correct.png")
		x.set_sound_victory()
		$Timer.start()
	
func incorrect(x):
	if Global.nivel1_level == 1:
		x.set_status("res://assets/icons/incorrect.png")
		x.set_sound_lose()
		$Timer.start()
	if Global.nivel1_level == 2:
		if seleccionados == 1:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
		elif seleccionados == 2:
			x.set_status("res://assets/icons/incorrect.png")
			x.set_sound_lose()
			$Timer.start()
	if Global.nivel1_level == 3:
		x.set_status("res://assets/icons/incorrect.png")
		x.set_sound_lose()
		$Timer.start()

# Timer
func _on_Timer_timeout():
	time_left -=1
	if time_left <= 0:
		if intentos_level <= 5:
			next()
		else:
			
			$HUD/TopPanel/Margin1/ToMenu.disabled = false
			$HUD/PopUpInfo.visible = false
			
			#$PopUp.visible = false
			#$PopUp.reset_nextlevel()
			next_level(score_level, score_total, Global.nivel1_level+1)

func reset_containers():
	for i in $Sounds.get_children():
		$Sounds.remove_child(i)
	for i in $Options.get_children():
		$Options.remove_child(i)

func next():
	# Timer
	$Timer.stop()
	# Containers
	$Options.visible = false
	# Vars
	time_left = 2
	seleccionados = 0	
	# Functions
	reset_containers()
	# Nivel 2
	eleccion_correcta = false
	
	if intentos_level < 5:
		if Global.nivel1_level == 1:
			set_sounds(1)
			_on_Escuchar_pressed()
			set_options(json, 1)
		if Global.nivel1_level == 2:
			set_sounds(2)
			_on_Escuchar_pressed()
			set_options(json, 1)
		if Global.nivel1_level == 3:
			set_sounds(2)
			_on_Escuchar_pressed()
			set_options(json, 1)
	else:
		if score_level >= 4:
			if Global.nivel1_level == 3:
				
				$Confetti.emitting = true
				$HUD/PopUpFinalizar.update_info("[center]FELICITACIONES HAS COMPLETADO\nTODOS LOS NIVELES\nPUNTAJE FINAL : "+str(score_total)+" DE 15 PUNTOS\n[img=50x50]res://assets/emojis/win-1.png[/img][img=50x50]res://assets/emojis/win-2.png[/img][img=50x50]res://assets/emojis/win-3.png[/img][/center]")
				$HUD/TopPanel/Margin1/ToMenu.disabled = true
				$Display/Margin2/Escuchar.visible = false
				$HUD/PopUpFinalizar/Sprite.visible = true
				
				#print("final")
#				popup_status = 1
#				$Particles2D.emitting = true
#				#$PopUp.update_info_rich("[center]FELICITACIONES HAS COMPLETADO\nTODOS LOS NIVELES\nPUNTAJE FINAL : "+str(score_total)+" DE 15 PUNTOS\n[img=50x50]res://assets/emojis/win-1.png[/img][img=50x50]res://assets/emojis/win-2.png[/img][img=50x50]res://assets/emojis/win-3.png[/img][/center]")
#				$PopUp.update_info_rich("[center]FELICITACIONES HAS COMPLETADO\nTODOS LOS NIVELES\nPUNTAJE FINAL : "+str(score_total)+" DE 15 PUNTOS[/center]")
#				$PopUp/VBox/Margin.rect_min_size.y = 90
#				$PopUp/VBox/Margin3.visible = true
#
#				$PopUp.update_info("FELICITACIONES HAS COMPLETADO\nTODOS LOS NIVELES\n\nPUNTAJE FINAL : "+str(score_total)+" DE 15 PUNTOS")
#				$TopPanel/Margin1/ToMenu.disabled = true
#				$PopUp.update_textures_aceptar("res://assets/buttons/nivels/finalizarbasic.png","res://assets/buttons/nivels/finalizarpress.png")
#				$PopUp.set_final()
#				$Main/VBox/Margin2/Escuchar.visible = false
#				$PopUp.visible = true
			else:
				#print("sigue avanzando")
				intentos_level += 1
				$Timer.start()
				
				$HUD/PopUpInfo.update_info("[center]FELICITACIONES SIGUE AVANZANDO\n\n[img=50x50]res://assets/emojis/nivel1.png[/img][img=50x50]res://assets/emojis/nivel2.png[/img][/center]")
				$HUD/TopPanel/Margin1/ToMenu.disabled = true
				$Display/Margin2/Escuchar.visible = false
				$HUD/PopUpInfo.visible = true
#				
				#$PopUp.update_info_rich("[center]FELICITACIONES SIGUE AVANZANDO\n\n[img=50x50]res://assets/emojis/nivel1.png[/img][img=50x50]res://assets/emojis/nivel2.png[/img][/center]")
#
#				$PopUp.update_info("FELICITACIONES SIGUE AVANZANDO")
#				$TopPanel/Margin1/ToMenu.disabled = true
#				$PopUp.set_nextlevel()
#				$Main/VBox/Margin2/Escuchar.visible = false
#				$PopUp.visible = true
		else:
			$HUD/PopUpReintentar.update_info("[center]HAS OBTENIDO : "+str(score_total)+" DE 15 PUNTOS\nSIGUELO INTENTANDO\n\n[img=50x50]res://assets/emojis/loser1.png[/img][img=50x50]res://assets/emojis/loser2.png[/img][/center]")
			$HUD/TopPanel/Margin1/ToMenu.disabled = true
			$Display/Margin2/Escuchar.visible = false
			$HUD/PopUpReintentar/Sprite.visible = true
			
			#print("siguelo intentando")
#			popup_status = 2
#			$PopUp.update_info_rich("[center]HAS OBTENIDO : "+str(score_total)+" DE 15 PUNTOS\nSIGUELO INTENTANDO\n\n[img=50x50]res://assets/emojis/loser1.png[/img][img=50x50]res://assets/emojis/loser2.png[/img][/center]")
#
#			$PopUp.update_info("HAS OBTENIDO : "+str(score_total)+" DE 15 PUNTOS\nSIGUELO INTENTANDO")
#			$TopPanel/Margin1/ToMenu.disabled = true
#			$PopUp.update_textures_aceptar("res://assets/buttons/nivels/reintentarbasic.png","res://assets/buttons/nivels/reintentarpress.png")
#			$PopUp.update_textures_rechazar("res://assets/buttons/nivels/finalizarbasic.png","res://assets/buttons/nivels/finalizarpress.png")
#			$Main/VBox/Margin2/Escuchar.visible = false
#			$PopUp.visible = true

func next_level(s,t,l):
	if l == 2:
		update_indicaciones("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"PRESIONA [color=#FFD948]LOS[/color] ANIMALES QUE ESCUCHES\"[/center]")
	
		#$Main.update_indicaciones_rich("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"PRESIONA [color=#FFD948]LOS[/color] ANIMALES QUE ESCUCHES\"[/center]")
		#$Main.update_indicaciones("\n\n\"PRESIONA LOS ANIMALES QUE ESCUCHES\"")
	if l == 3:
		update_indicaciones("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"PRESIONA [color=#FFD948]EL[/color] ANIMAL [color=#FFD948]NO[/color] ESCUCHADO\"[/center]")
	
		#$Main.update_indicaciones_rich("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"PRESIONA [color=#FFD948]EL[/color] ANIMAL [color=#FFD948]NO[/color] ESCUCHADO\"[/center]")
		#$Main.update_indicaciones("\n\n\"PRESIONA EL ANIMAL NO ESCUCHADO\"")
	#$Main/VBox/Margin2/Escuchar.visible = true
	$Display/Margin2/Escuchar.visible = true
	# Timer
	$Timer.stop()
	# Containers
	$Options.visible = false
	# Vars
	seleccionados = 0
	intentos_level = 0
	Global.update_nivel1_level(l)
	#level = l
	score_level = 0
	Global.update_nivel1_score(t)
	#score_user = t
	score_total = Global.nivel1_score
	time_left = 2
	#popup_status = 0
	eleccion_correcta = false
	# Functions
	reset_containers()
	$HUD.update_level(Global.nivel1_level)
	#$TopPanel.update_level(level)
	json = read_json()
	set_objects(json)
	if Global.nivel1_level == 2:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 1)
	if Global.nivel1_level == 3:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 1)

#func reintentar():
#	$TopPanel.update_score(score_user)
#	$Main/VBox/Margin2/Escuchar.visible = true
#	# Timer
#	$Timer.stop()
#	# Containers
#	$ObjectsOptions.visible = false
#	# Vars
#	seleccionados = 0
#	intentos_level = 0
#	#level = 1
#	score_level = 0
#	#score_user = 0
#	score_total = score_user
#	time_left = 2
#	#popup_status = 0
#	eleccion_correcta = false
#	# Functions
#	reset_containers()
#	json = read_json()
#	set_objects(json)
#	if level == 1:
#		set_sounds(1)
#		_on_Escuchar_pressed()
#		set_options(json, 1)
#	if level == 2:
#		set_sounds(2)
#		_on_Escuchar_pressed()
#		set_options(json, 1)
#	if level == 3:
#		set_sounds(2)
#		_on_Escuchar_pressed()
#		set_options(json, 1)
