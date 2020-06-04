extends Node2D

export(PackedScene) var Objeto
const objects_file = "res://data/comparation.json"
var json
var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var seleccionados = 0
var intentos_level = 0
var score_level = 0
var score_total = 0
var time_left = 2

func _ready():
	# HUD
	$HUD.update_level(Global.nivels_level)
	$HUD.update_score(Global.nivels_score)
	score_total = Global.nivels_score
	# Display
	if Global.nivels_level == 1:
		update_indicaciones("[center]ESCUCHA CON ATENCION [img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"E IDENTIFICA SI LAS PALABRAS SON [color=#FFD948]IGUALES[/color] O [color=#FFD948]DIFERENTES[/color]\"[/center]")
	# Transition
	$Transition.fadeOut()
	yield($Transition/AnimationPlayer, "animation_finished")
	# Childs
	add_child(audio)
	# Functions
	json = read_json()
	set_objects(json)
	set_sounds(2)
	_on_Escuchar_pressed()
	set_options(json, 0)
	
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
		
	while deck.size() != 0:
		var indexList = range(deck.size())
		randomize()
		var y = randi()%indexList.size()
		var residuo = y % 2
		if residuo == 0:
			for z in x:
				if z == deck[y]:
					var obj = Objeto.instance()
					obj.set_id(z)
					obj.set_nombre(x[z]["name"])
					obj.set_code(x[z]["code"])
					obj.set_sound(x[z]["sound"])
					obj.set_image(x[z]["image"])
					$Objects.add_child(obj)
				if z == deck[y+1]:
					var obj = Objeto.instance()
					obj.set_id(z)
					obj.set_nombre(x[z]["name"])
					obj.set_code(x[z]["code"])
					obj.set_sound(x[z]["sound"])
					obj.set_image(x[z]["image"])
					$Objects.add_child(obj)
			indexList.remove(y+1)
			deck.remove(y+1)
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

	var card_x = 480 - 10
	var card_width = 170 + 150 +10 + 10
	var in_list = range(options.size())
	var c = 0
	for i in range(options.size()):
		for z in x:
			if z == options[c] and c < in_list.size():
				var obj = Objeto.instance()
				obj.z_index = 1
				obj.set_id(z)
				obj.set_nombre(x[z]["name"])
				obj.set_code(x[z]["code"])
				obj.set_sound(x[z]["sound"])
				obj.set_image(x[z]["image"])
				obj.position = Vector2(card_x,360)
				card_x = card_x + card_width
				$Options.add_child(obj)
		c+=1

func _on_Escuchar_pressed():
	if Global.nivels_level == 1 and seleccionados != 1:
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
				$Display/Margin2/Escuchar.disabled = false
				$Display/Comparation.visible = false
				$Display/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")
				break
		if  seleccionados != 1:
			$Display/Margin2/Escuchar.disabled = false
			$Display/Comparation.visible = true
			$Display/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiobasic.png")

func _on_Igual_pressed():
	$Display/Comparation.visible = false
	if Global.nivels_level == 1 and seleccionados == 0:
		seleccionados += 1
		intentos_level += 1
		audio.stop()
		if $Sounds.get_child(0).code == $Sounds.get_child(1).code:
			correct()
		else:
			incorrect()

func _on_Diferente_pressed():
	$Display/Comparation.visible = false
	if Global.nivels_level == 1 and seleccionados == 0:
		seleccionados += 1
		intentos_level += 1
		audio.stop()
		if $Sounds.get_child(0).code != $Sounds.get_child(1).code:
			correct()
		else:
			incorrect()

func correct():
	if Global.nivels_level == 1:
		score_level += 1
		score_total += 1
		$HUD.update_score(score_total)
		$Timer.start()
		$HUD.show_popup_comparation("res://assets/icons/correct.png", "res://assets/sounds/Ganar.ogg")
		$Options.visible = true

func incorrect():
	if Global.nivels_level == 1:
		$Timer.start()
		$HUD.show_popup_comparation("res://assets/icons/incorrect.png", "res://assets/sounds/Perder.ogg")
		$Options.visible = true

func _on_Timer_timeout():
	time_left -=1
	if time_left <= 0:
		if intentos_level <= 8:
			$HUD.reset_popup_comparation()
			next()

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

	if intentos_level < 8:
		if Global.nivels_level == 1:
			set_sounds(2)
			_on_Escuchar_pressed()
			set_options(json, 0)
	else:
		if score_level >= 7:
			$Display/Margin2/Escuchar.visible = false
			$HUD.show_popup_finalizar("[center]¡FELICITACIONES!\nPUNTAJE FINAL : "+str(score_total)+" DE 8 PUNTOS\n\n[img=50x50]res://assets/emojis/win1.png[/img][img=50x50]res://assets/emojis/win2.png[/img][img=50x50]res://assets/emojis/win3.png[/img][/center]")
		else:
			$Display/Margin2/Escuchar.visible = false
			$HUD.show_popup_reintentar("[center]HAS OBTENIDO : "+str(score_total)+" DE 8 PUNTOS\nSIGUELO INTENTANDO\n\n[img=50x50]res://assets/emojis/loser1.png[/img][img=50x50]res://assets/emojis/loser2.png[/img][/center]")
