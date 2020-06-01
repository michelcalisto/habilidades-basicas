extends Control

signal to_title_screen

func update_score(x):
	$Margin3/Score.text = "Puntaje : " + str(x)

func update_level(x):
	$Margin2/Nivel.text = "Nivel : " + str(x)

func _on_ToTitleScreen_pressed():
	emit_signal("to_title_screen")
