extends Node2D

export(PackedScene) var Objeto
const objects_file = "res://data/objects.json"
var time_left = 0
var score = 0
var time_final = 0

func _ready():
	yield($ColorRect/AnimationPlayer, "animation_finished")
	$ColorRect.visible = false
	time_left = 2
	time_final = 2
	$ObjectsContainer.visible = false
	load_objects()
	first_sound()
	load_opciones()

func load_objects():
	var file = File.new()
	if file.file_exists(objects_file):
		file.open(objects_file, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			create_deck(data)
		else:
			printerr("Corrupted data!")
	else:
		printerr("File don't exist!")

func create_deck(json):
	var deck = Array()
	for i in json:
		deck.append(i)
	var indexList = range(deck.size())
	for i in range(deck.size()):
		randomize()
		var x = randi()%indexList.size()	
		for y in json:
			if y == deck[x]:
				var obj = Objeto.instance()
				obj.set_id(y)
				obj.set_nombre(json[y]["name"])
				obj.set_code(json[y]["code"])
				obj.set_sound(json[y]["sound"])
				obj.set_image(json[y]["image"])
				obj.position = Vector2(80,500)
				$ObjectsContainer.add_child(obj)
		indexList.remove(x)
		deck.remove(x)

func first_sound():
	# pasar el audio del objeto al button
	var count = 0
	var obj_x = 640
	var obj_width = 140
	for i in $ObjectsContainer.get_children():
		if count >= $ObjectsContainer.get_child_count() - 1:
			var obj = $ObjectsContainer.get_child(count)
			obj.position = Vector2(obj_x,300)
			obj_x = obj_x + obj_width
			$ObjectsContainer.remove_child(i)
			$ObjectsSoundContainer.add_child(obj)
		else:
			count += 1

func load_opciones():
	var file = File.new()
	if file.file_exists(objects_file):
		file.open(objects_file, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			get_options(data)
		else:
			printerr("Corrupted data!")
	else:
		printerr("File don't exist!")

func get_options(json):
	var count = 0
	var card_x = 400
	var card_width = 140
	var deck = Array()
	var tres = Array()
	for i in json:
		if json[i]["code"] != $ObjectsSoundContainer.get_child(0).code:
			deck.append(i)
	
	for y in json:
		if json[y]["code"] == $ObjectsSoundContainer.get_child(0).code:
			tres.append(y)
			
	var indexList = range(deck.size())
	for i in range(2):
		randomize()
		var x = randi()%indexList.size()	
		for y in deck:
			if y == deck[x]:
				tres.append(y)
		indexList.remove(x)
		deck.remove(x)
	
	var indice_tres = 0
	
	var in_list = range(tres.size())
	for i in range(3):
		randomize()
		var x = randi()%in_list.size()	
		for y in json:
			if y == tres[x]:
				var obj = Objeto.instance()
				obj.set_id(y)
				obj.set_nombre(json[y]["name"])
				obj.set_code(json[y]["code"])
				obj.set_sound(json[y]["sound"])
				obj.set_image(json[y]["image"])
				obj.position = Vector2(card_x,500)
				obj.add_to_group("deck")
				obj.connect("is_code", self, "_is_code", [obj])
				card_x = card_x + card_width
				$ObjectsOptionsContainer.add_child(obj)
		in_list.remove(x)
		tres.remove(x)

func _is_code(x):
	if $ObjectsSoundContainer.get_child(0).code == x.code:
		win()
	else:
		game_over()

func game_over():
	print("game over")
	#$Control/Error.visible = true
	#$Timer.start()

func win():
	score += 1
	#$MarginContainer.updateScore(score)
	print("you win")
	#$Control/Ok.visible = true
	#$Timer.start()
