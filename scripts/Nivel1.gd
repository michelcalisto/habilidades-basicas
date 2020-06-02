extends Node2D

#var audiobtn = AudioStreamPlayer.new()
#var oggbtn = AudioStreamOGGVorbis.new()
export(PackedScene) var Objeto
const objects_file = "res://data/animals.json"
var json
var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
#var seleccionados = 0
#var intentos_level = 0
var level = 1
#var score_level = 0
#var score_user = 0
var score_total = 0
#var time_left = 2
#var popup_status = 0
#var eleccion_correcta = false

func _ready():
	# PopUp
	#$PopUp.visible = false
	# HUD
	$HUD.update_level(level)
	$HUD.update_score(score_total)
	#$TopPanel.update_level(level)
	#$TopPanel.update_score(score_total)
	# Display
	update_indicaciones("[center]¡ESCUCHA CON ATENCION! [img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\"PRESIONA [color=#FFD948]EL[/color] ANIMAL ESCUCHADO\"[/center]")
	#$Main.update_indicaciones_rich("[center]ESCUCHA CON ATENCION [img=40x40]res://assets/emojis/emoji_u1f449_1f3fb.png[/img] [img=40x40]res://assets/emojis/emoji_u1f442_1f3fb.png[/img]\n\n\"PRESIONA [color=#FFD948]EL[/color] ANIMAL ESCUCHADO\"[/center]")
	#$Main.update_indicaciones("ESCUCHA CON ATENCION\n\n\"PRESIONA EL ANIMAL ESCUCHADO\"")
	# Transition
	$Transition.fadeOut()
#	$Transition.visible = true
#	$Transition/AnimationPlayer.play("fade-out")
#	yield($Transition/AnimationPlayer, "animation_finished")
#	$Transition.visible = false
	# Containers
#	$Objects.visible = false
#	$ObjectsSounds.visible = false
#	$ObjectsOptions.visible = false
	# Childs
	add_child(audio)
	# Functions
	json = read_json()
	set_objects(json)
	set_sounds(1)
	_on_Escuchar_pressed()
	set_options(json, 1)
#	add_child(audiobtn)
#	oggbtn = load("res://assets/sounds/click.ogg")
#	oggbtn.loop = false
#	audiobtn.stream = oggbtn

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
	pass # Replace with function body.
