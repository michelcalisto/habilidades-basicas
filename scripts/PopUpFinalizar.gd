extends Control

var audiobtn = AudioStreamPlayer.new()
var oggbtn = AudioStreamOGGVorbis.new()

func _ready():
	# Childs
	add_child(audiobtn)
	oggbtn = load("res://assets/sounds/click.ogg")
	oggbtn.loop = false
	audiobtn.stream = oggbtn

func update_info(x):
	$Sprite/VBox/Margin/Info.clear()
	$Sprite/VBox/Margin/Info.append_bbcode(str(x))

func _on_Finalizar_pressed():
	audiobtn.play()
	$Sprite.visible = false
	Global.update_nivel1_level(1)
	Global.update_nivel1_score(0)
	$Transition.fadeIn("TitleScreen")
