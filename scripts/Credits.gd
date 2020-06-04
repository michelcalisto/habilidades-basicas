extends Control

func _ready():
	# Transition
	$Transition.fadeOut()
	# Scroll Credits
	$Tween.interpolate_property($Scrolling, "position", Vector2(0, 610), Vector2(0, -280), 20, Tween.TRANS_LINEAR, 0)
	$Tween.start()

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		$Transition.fadeIn("TitleScreen")
	if Input.is_action_pressed("left_click"):
		$Transition.fadeIn("TitleScreen")
