extends Control

func _on_TextureButton_pressed():
	get_tree().change_scene("res://nivel1/Nivel1.tscn")

func _on_TextureButton2_pressed():
	get_tree().change_scene("res://nivel2/Nivel2.tscn")

func _on_TextureButton3_pressed():
	get_tree().change_scene("res://nivel3/Nivel3.tscn")
