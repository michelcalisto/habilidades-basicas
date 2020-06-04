extends Control

func _ready():
	$Transition.fadeOut()
	$Display/Margin1/Title.text = Global.information_title
	$Display/Margin2/Description.clear()
	$Display/Margin2/Description.append_bbcode(Global.information_description)
	
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		$Transition.fadeIn(Global.information_redirect)
	if Input.is_action_pressed("left_click"):
		$Transition.fadeIn(Global.information_redirect)
