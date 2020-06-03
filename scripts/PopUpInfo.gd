extends Sprite

func update_info(x):
	$Margin/Info.clear()
	$Margin/Info.append_bbcode(str(x))
