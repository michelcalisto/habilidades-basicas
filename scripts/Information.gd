extends Control

func _ready():
	$Transition.fadeOut()

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		$Transition.fadeIn("TitleScreen")
	if Input.is_action_pressed("left_click"):
		$Transition.fadeIn("TitleScreen")
