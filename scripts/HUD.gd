extends Control

var audiobtn = AudioStreamPlayer.new()
var oggbtn = AudioStreamOGGVorbis.new()

func _ready():
	# Childs
	add_child(audiobtn)
	oggbtn = load("res://assets/sounds/click.ogg")
	oggbtn.loop = false
	audiobtn.stream = oggbtn

func update_level(x):
	$TopPanel/Margin2/Nivel.text = "Nivel : " + str(x)

func update_score(x):
	$TopPanel/Margin3/Score.text = "Puntaje : " + str(x)

func _on_ToMenu_pressed():
	audiobtn.play()
	$PopUpBack/Sprite.visible = true

func show_popup_info():
	$TopPanel/Margin1/ToMenu.disabled = true
	$PopUpInfo.visible = true

func reset_popup_info():
	$TopPanel/Margin1/ToMenu.disabled = false
	$PopUpInfo.visible = false

func show_popup_reintentar(x):
	$PopUpReintentar.update_info(x)
	$TopPanel/Margin1/ToMenu.disabled = true
	$PopUpReintentar/Sprite.visible = true

func show_popup_finalizar(x):
	$PopUpFinalizar.update_info(x)
	$TopPanel/Margin1/ToMenu.disabled = true
	$PopUpFinalizar/Sprite.visible = true
	$PopUpFinalizar/Confetti.emitting = true
