extends Control

var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()

func _ready():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadeout")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	$ColorRect.visible = false
	# Childs
	add_child(audio)
	ogg = load("res://assets/sounds/title.ogg")
	ogg.loop = true
	audio.stream = ogg
	audio.play()

func _on_Nivel1_pressed():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://instrucciones/Instrucciones1.tscn")

func _on_Nivel2_pressed():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://instrucciones2/Instrucciones2.tscn")

func _on_Nivel3_pressed():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://instrucciones3/Instrucciones3.tscn")


func _on_Nivel4_pressed():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://creditos/Creditos.tscn")
