extends TextureRect

func update_indicaciones(x):
	$VBox/Margin1/Indicaciones.text = str(x)

func update_indicaciones_rich(x):
	$VBox/Margin1/RichTextLabel.clear()
	$VBox/Margin1/RichTextLabel.append_bbcode(str(x))
	#$VBox/Margin1/RichTextLabel.
