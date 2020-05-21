extends HBoxContainer

func update_score(x):
	$Margin3/Score.text = "Puntaje : " + str(x)

func update_level(x):
	$Margin2/Nivel.text = "Nivel : " + str(x)
