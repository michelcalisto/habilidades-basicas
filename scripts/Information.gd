extends Control

func _ready():
	$Transition.fadeOut()
	$Background/Margin1/VBox/Margin1/Title.text = SInfo.title
	$Background/Margin1/VBox/Margin2/Description.clear()
	$Background/Margin1/VBox/Margin2/Description.append_bbcode(SInfo.description)
	
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		$Transition.fadeIn(SInfo.redirect)
	if Input.is_action_pressed("left_click"):
		$Transition.fadeIn(SInfo.redirect)
