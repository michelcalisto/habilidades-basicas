extends Node2D

export(PackedScene) var Objeto
const objects_file = "res://data/instruments.json"
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
		update_indicaciones("[center]ESCUCHA CON ATENCION [img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"E IDENTIFICA SI LOS SONIDOS\n SON [color=#FFD948]IGUALES[/color] O [color=#FFD948]DIFERENTES[/color] EN INTENSIDAD\"[/center]")
#		update_indicaciones("[center]ESCUCHA CON ATENCION [img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"E IDENTIFICA SI LAS PALABRAS SON [color=#FFD948]IGUALES[/color] O [color=#FFD948]DIFERENTES[/color]\"[/center]")
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
	
	print($Objects.get_child_count())
	print($Sounds.get_child_count())
	
	var count = 0
	for i in $Objects.get_children():
		var obj = $Objects.get_child(count)
		print(obj.get_code())
		count+=1
		
	var countt = 0
	for i in $Sounds.get_children():
		var obj = $Sounds.get_child(countt)
		print(obj.get_code())
		countt+=1

	
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
		for z in x:
			if z == deck[y]:
				var obj = Objeto.instance()
				obj.set_id(z)
				obj.set_nombre(x[z]["name"])
				obj.set_code(x[z]["code"])
				
				var volume = Array()
				for i in x[z]["sounds"]:
					if Global.nivels_level == 1:
						if (x[z]["sounds"][str(i)]["duration"] == "m" and (x[z]["sounds"][str(i)]["volume"] == "l" or x[z]["sounds"][str(i)]["volume"] == "h")):
							volume.append(i)

					if Global.nivels_level == 2:
						if (x[z]["sounds"][str(i)]["duration"] == "m"):
							volume.append(i)
				
				var indexSounds = range(volume.size())
				randomize()
				var ran = randi()%indexSounds.size()
				obj.set_sound(x[z]["sounds"][str(volume[ran])]["url"])
				$Objects.add_child(obj)
				
				var obj2 = Objeto.instance()
				obj2.set_id(z)
				obj2.set_nombre(x[z]["name"])
				obj2.set_code(x[z]["code"])
				
				var volume2 = Array()
				for i in x[z]["sounds"]:
					if Global.nivels_level == 1:
						if (x[z]["sounds"][str(i)]["duration"] == "m" and (x[z]["sounds"][str(i)]["volume"] == "l" or x[z]["sounds"][str(i)]["volume"] == "h")):
							volume2.append(i)
							
					if Global.nivels_level == 2:
						if (x[z]["sounds"][str(i)]["duration"] == "m"):
							volume2.append(i)
						
				var indexSounds2 = range(volume2.size())
				randomize()
				var ran2 = randi()%indexSounds2.size()
				obj2.set_sound(x[z]["sounds"][str(volume2[ran2])]["url"])
				$Objects.add_child(obj2)

		indexList.remove(y+1)
		deck.remove(y+1)
		indexList.remove(y)
		deck.remove(y)

func set_sounds(x):
	var count = 0
	var countAudio = 0
#	print("cha")
	for i in $Objects.get_children():
#		print("cha1")
		if count >= $Objects.get_child_count() - x:
			var obj = $Objects.get_child(count)
			$Objects.remove_child(i)
			$Sounds.add_child(obj)
			print(obj)
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
				obj.set_sound(x[z]["sounds"]["01"]["url"])
#				obj.set_sound(x[z]["sound"])
#				obj.set_image(x[z]["image"])
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
				print(i.get_sound())
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
	if Global.nivels_level == 2 and seleccionados != 1:
		$Display/Margin2/Escuchar.texture_normal = load("res://assets/buttons/nivels/audiopress.png")
		$Display/Margin2/Escuchar.disabled = true
		for i in $Sounds.get_children():
			if seleccionados != 1:
				print(i.get_sound())
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
#		if $Sounds.get_child(0).code == $Sounds.get_child(1).code:
#			correct()
#		else:
#			incorrect()
		if $Sounds.get_child(0).sound == $Sounds.get_child(1).sound:
			correct()
		else:
			incorrect()
	if Global.nivels_level == 2 and seleccionados == 0:
		seleccionados += 1
		intentos_level += 1
		audio.stop()
#		if $Sounds.get_child(0).code == $Sounds.get_child(1).code:
#			correct()
#		else:
#			incorrect()
		if $Sounds.get_child(0).sound == $Sounds.get_child(1).sound:
			correct()
		else:
			incorrect()

func _on_Diferente_pressed():
	print("........")
	print($Sounds.get_child(0).sound)
	print($Sounds.get_child(1).sound)
	$Display/Comparation.visible = false
	if Global.nivels_level == 1 and seleccionados == 0:
		seleccionados += 1
		intentos_level += 1
		audio.stop()
#		if $Sounds.get_child(0).code != $Sounds.get_child(1).code:
#			correct()
#		else:
#			incorrect()
		if $Sounds.get_child(0).sound != $Sounds.get_child(1).sound:
			correct()
		else:
			incorrect()
	if Global.nivels_level == 2 and seleccionados == 0:
		seleccionados += 1
		intentos_level += 1
		audio.stop()
#		if $Sounds.get_child(0).code != $Sounds.get_child(1).code:
#			correct()
#		else:
#			incorrect()
		print($Sounds.get_child(0).sound)
		print($Sounds.get_child(1).sound)
		if $Sounds.get_child(0).sound != $Sounds.get_child(1).sound:
			
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
#		$Options.visible = true
	if Global.nivels_level == 2:
		score_level += 1
		score_total += 1
		$HUD.update_score(score_total)
		$Timer.start()
		$HUD.show_popup_comparation("res://assets/icons/correct.png", "res://assets/sounds/Ganar.ogg")
#		$Options.visible = true

func incorrect():
	if Global.nivels_level == 1:
		$Timer.start()
		$HUD.show_popup_comparation("res://assets/icons/incorrect.png", "res://assets/sounds/Perder.ogg")
#		$Options.visible = true
	if Global.nivels_level == 2:
		$Timer.start()
		$HUD.show_popup_comparation("res://assets/icons/incorrect.png", "res://assets/sounds/Perder.ogg")
#		$Options.visible = true

func _on_Timer_timeout():
	time_left -=1
	if time_left <= 0:
		if intentos_level <= 8:
			$HUD.reset_popup_comparation()
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
		if Global.nivels_level == 2:
			set_sounds(2)
			_on_Escuchar_pressed()
			set_options(json, 0)
	else:
		if score_level >= 7:
			if Global.nivels_level == 2:
				$Display/Margin2/Escuchar.visible = false
				$HUD.show_popup_finalizar("[center]¡FELICITACIONES!\nPUNTAJE FINAL : "+str(score_total)+" DE 16 PUNTOS\n\n[img=50x50]res://assets/emojis/win1.png[/img][img=50x50]res://assets/emojis/win2.png[/img][img=50x50]res://assets/emojis/win3.png[/img][/center]")
			else:
				intentos_level += 1
				$Timer.start()
				$Display/Margin2/Escuchar.visible = false
				$HUD.show_popup_info()
#			$Display/Margin2/Escuchar.visible = false
#			$HUD.show_popup_finalizar("[center]¡FELICITACIONES!\nPUNTAJE FINAL : "+str(score_total)+" DE 8 PUNTOS\n\n[img=50x50]res://assets/emojis/win1.png[/img][img=50x50]res://assets/emojis/win2.png[/img][img=50x50]res://assets/emojis/win3.png[/img][/center]")
		else:
			$Display/Margin2/Escuchar.visible = false
			$HUD.show_popup_reintentar("[center]HAS OBTENIDO : "+str(score_total)+" DE 16 PUNTOS\nSIGUELO INTENTANDO\n\n[img=50x50]res://assets/emojis/loser1.png[/img][img=50x50]res://assets/emojis/loser2.png[/img][/center]")

func next_level(s,t,l):
	if l == 2:
		update_indicaciones("[center][img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"E IDENTIFICA SI LOS SONIDOS\n SON [color=#FFD948]IGUALES[/color] O [color=#FFD948]DIFERENTES[/color] EN INTENSIDAD\"[/center]")
	$Display/Margin2/Escuchar.visible = true
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
#	eleccion_correcta = false
	# Functions
	reset_containers()
	for i in $Objects.get_children():
		$Objects.remove_child(i)
	print($Objects.get_child_count())
	print($Sounds.get_child_count())
	
	$HUD.update_level(Global.nivels_level)
	
#	add_child(audio)
		
	json = read_json()
	set_objects(json)

#	if Global.nivels_level == 2:
	set_sounds(2)
	_on_Escuchar_pressed()


	print($Objects.get_child_count())
	print($Sounds.get_child_count())
	var count = 0
	for i in $Objects.get_children():
		var obj = $Objects.get_child(count)
		print(obj.get_code())
		count+=1
		
	var countt = 0
	for i in $Sounds.get_children():
		var obj = $Sounds.get_child(countt)
		print(obj.get_code())
		countt+=1
