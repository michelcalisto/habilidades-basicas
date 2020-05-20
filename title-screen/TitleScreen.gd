extends Control

func _ready():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadeout")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	$ColorRect.visible = false

func _on_TextureButtonNivel1_pressed():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://nivel1-1/Nivel1-1.tscn")

func _on_TextureButton2_pressed():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://nivel2-1/Nivel2-1.tscn")

func _on_TextureButton3_pressed():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://nivel2-1x/Nivel2-1.tscn")

