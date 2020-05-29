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

func _ready():
	# PopUp
	$PopUp.visible = false
	# Labels
	$TopPanel.update_level(level)
	$TopPanel.update_score(score_total)
	$Main.update_indicaciones_rich("[center]ESCUCHA CON ATENCION [img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"PRESIONA [color=#FFD948]EL[/color] ANIMAL ESCUCHADO\"[/center]")
	$Main.update_indicaciones("ESCUCHA CON ATENCION\n\n\"PRESIONA EL ANIMAL ESCUCHADO\"")
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
	set_sounds(1)
	_on_Escuchar_pressed()
	set_options(json, 1)
	add_child(audiobtn)
	oggbtn = load("res://assets/sounds/click.ogg")
	oggbtn.loop = false
	audiobtn.stream = oggbtn

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
				$ObjectsOptions.add_child(obj)
		in_list.remove(y)
		options.remove(y)

# Main
func _on_Escuchar_pressed():
	if level == 1 and seleccionados != 1:
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Main/VBox/Margin2/Escuchar.disabled = true
		for i in $ObjectsSounds.get_children():
			if seleccionados != 1:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Main/VBox/Margin2/Escuchar.disabled = false
		$ObjectsOptions.visible = true
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")
	if level == 2 and seleccionados != 2:
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Main/VBox/Margin2/Escuchar.disabled = true
		for i in $ObjectsSounds.get_children():
			if seleccionados != 2:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Main/VBox/Margin2/Escuchar.disabled = false
		$ObjectsOptions.visible = true
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")
	if level == 3 and seleccionados != 1:
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Main/VBox/Margin2/Escuchar.disabled = true
		for i in $ObjectsSounds.get_children():
			if seleccionados != 1:
				ogg = load(i.get_sound())
				ogg.loop = false
				audio.stream = ogg
				audio.play()
				yield(audio, "finished")
			else:
				break
		$Main/VBox/Margin2/Escuchar.disabled = false
		$ObjectsOptions.visible = true
		$Main/VBox/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")

# Funcion que se ejecuta al clickear en un objeto
func _is_code(x):
	if level == 1 and seleccionados == 0:
		seleccionados += 1
		intentos_level += 1
		audio.stop()
		var existe = false
		for i in $ObjectsSounds.get_children():
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
				if i.code == x.code:
					existe = true
			if existe == true:
				correct(x)
			else:
				incorrect(x)
	if level == 3 and seleccionados == 0:
		seleccionados += 1
		intentos_level += 1
		audio.stop()
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
		score_level += 1
		score_total += 1
		$TopPanel.update_score(score_total)
		x.set_status("res://assets/icons/correct.png")
		x.set_sound_victory()
		$Timer.start()
	
func incorrect(x):
	if level == 1:
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
	
	if intentos_level < 5:
		if level == 1:
			set_sounds(1)
			_on_Escuchar_pressed()
			set_options(json, 1)
		if level == 2:
			set_sounds(2)
			_on_Escuchar_pressed()
			set_options(json, 1)
		if level == 3:
			set_sounds(2)
			_on_Escuchar_pressed()
			set_options(json, 1)
	else:
		if score_level >= 4:
			if level == 3:
				popup_status = 1
				$Particles2D.emitting = true
				#$PopUp.update_info_rich("[center]FELICITACIONES HAS COMPLETADO\nTODOS LOS NIVELES\nPUNTAJE FINAL : "+str(score_total)+" DE 15 PUNTOS\n[img=50x50]res://assets/emojis/win-1.png[/img][img=50x50]res://assets/emojis/win-2.png[/img][img=50x50]res://assets/emojis/win-3.png[/img][/center]")
				$PopUp.update_info_rich("[center]FELICITACIONES HAS COMPLETADO\nTODOS LOS NIVELES\nPUNTAJE FINAL : "+str(score_total)+" DE 15 PUNTOS[/center]")
				$PopUp/VBox/Margin.rect_min_size.y = 90
				$PopUp/VBox/Margin3.visible = true
				
				$PopUp.update_info("FELICITACIONES HAS COMPLETADO\nTODOS LOS NIVELES\n\nPUNTAJE FINAL : "+str(score_total)+" DE 15 PUNTOS")
				$TopPanel/Margin1/ToMenu.disabled = true
				$PopUp.update_textures_aceptar("res://assets/buttons/nivels/finalizarbasic.png","res://assets/buttons/nivels/finalizarpress.png")
				$PopUp.set_final()
				$Main/VBox/Margin2/Escuchar.visible = false
				$PopUp.visible = true
			else:
				intentos_level += 1
				$Timer.start()
				$PopUp.update_info_rich("[center]FELICITACIONES SIGUE AVANZANDO\n\n[img=50x50]res://assets/emojis/nivel1.png[/img][img=50x50]res://assets/emojis/nivel2.png[/img][/center]")
	
				$PopUp.update_info("FELICITACIONES SIGUE AVANZANDO")
				$TopPanel/Margin1/ToMenu.disabled = true
				$PopUp.set_nextlevel()
				$Main/VBox/Margin2/Escuchar.visible = false
				$PopUp.visible = true
		else:
			popup_status = 2
			$PopUp.update_info_rich("[center]HAS OBTENIDO : "+str(score_total)+" DE 15 PUNTOS\nSIGUELO INTENTANDO\n\n[img=50x50]res://assets/emojis/loser1.png[/img][img=50x50]res://assets/emojis/loser2.png[/img][/center]")
	
			$PopUp.update_info("HAS OBTENIDO : "+str(score_total)+" DE 15 PUNTOS\nSIGUELO INTENTANDO")
			$TopPanel/Margin1/ToMenu.disabled = true
			$PopUp.update_textures_aceptar("res://assets/buttons/nivels/reintentarbasic.png","res://assets/buttons/nivels/reintentarpress.png")
			$PopUp.update_textures_rechazar("res://assets/buttons/nivels/finalizarbasic.png","res://assets/buttons/nivels/finalizarpress.png")
			$Main/VBox/Margin2/Escuchar.visible = false
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
		$Main/VBox/Margin2/Escuchar.visible = true
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
		$Main.update_indicaciones_rich("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"PRESIONA [color=#FFD948]LOS[/color] ANIMALES QUE ESCUCHES\"[/center]")
		$Main.update_indicaciones("\n\n\"PRESIONA LOS ANIMALES QUE ESCUCHES\"")
	if l == 3:
		$Main.update_indicaciones_rich("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"PRESIONA [color=#FFD948]EL[/color] ANIMAL [color=#FFD948]NO[/color] ESCUCHADO\"[/center]")
		$Main.update_indicaciones("\n\n\"PRESIONA EL ANIMAL NO ESCUCHADO\"")
	$Main/VBox/Margin2/Escuchar.visible = true
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
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 1)

func reintentar():
	$TopPanel.update_score(score_user)
	$Main/VBox/Margin2/Escuchar.visible = true
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
	# Functions
	reset_containers()
	json = read_json()
	set_objects(json)
	if level == 1:
		set_sounds(1)
		_on_Escuchar_pressed()
		set_options(json, 1)
	if level == 2:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 1)
	if level == 3:
		set_sounds(2)
		_on_Escuchar_pressed()
		set_options(json, 1)
