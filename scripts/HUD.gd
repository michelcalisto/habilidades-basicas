extends Control

func _ready():
	pass # Replace with function body.

func update_score(x):
	$Margin3/Score.text = "Puntaje : " + str(x)

func update_level(x):
	$Margin2/Nivel.text = "Nivel : " + str(x)

func _on_ToMenu_pressed():
	pass # Replace with function body.
