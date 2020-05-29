extends Control

var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var audiobtn = AudioStreamPlayer.new()
var oggbtn = AudioStreamOGGVorbis.new()

func _ready():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadeout")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	$ColorRect.visible = false
	# Childs
	add_child(audio)
	add_child(audiobtn)
	ogg = load("res://assets/sounds/title.ogg")
	oggbtn = load("res://assets/sounds/drop_004.ogg")
	ogg.loop = true
	oggbtn.loop = false
	audio.stream = ogg
	audiobtn.stream = oggbtn
	audio.play()

func _on_Nivel1_pressed():
	audiobtn.play()
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://instrucciones/Instrucciones1.tscn")

func _on_Nivel2_pressed():
	audiobtn.play()
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://instrucciones2/Instrucciones2.tscn")

func _on_Nivel3_pressed():
	audiobtn.play()
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://instrucciones3/Instrucciones3.tscn")


func _on_Nivel4_pressed():
	audiobtn.play()
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://creditos/Creditos.tscn")
