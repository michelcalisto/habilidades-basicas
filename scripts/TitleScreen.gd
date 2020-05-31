extends Control

var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var audiobtn = AudioStreamPlayer.new()
var oggbtn = AudioStreamOGGVorbis.new()

func _ready():
	$Transition.fadeOut()
	# Childs
	add_child(audio)
	add_child(audiobtn)
	ogg = load("res://assets/sounds/title.ogg")
	oggbtn = load("res://assets/sounds/click.ogg")
	ogg.loop = true
	oggbtn.loop = false
	audio.stream = ogg
	audiobtn.stream = oggbtn
	audio.play()

func _on_Nivel1_pressed():
	audiobtn.play()

func _on_Nivel2_pressed():
	audiobtn.play()

func _on_Nivel3_pressed():
	audiobtn.play()

func _on_Credits_pressed():
	audiobtn.play()
