extends Control

var audiobtn = AudioStreamPlayer.new()
var oggbtn = AudioStreamOGGVorbis.new()

func _ready():
	# Childs
	add_child(audiobtn)
	oggbtn = load("res://assets/sounds/click.ogg")
	oggbtn.loop = false
	audiobtn.stream = oggbtn

func _on_Si_pressed():
	audiobtn.play()
	$Sprite.visible = false
	$Transition.fadeIn("TitleScreen")

func _on_No_pressed():
	audiobtn.play()
	$Sprite.visible = false
