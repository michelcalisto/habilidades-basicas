extends Control

func _ready():
	$Transition.fadeOut()

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		$Transition.fadeIn()
	if Input.is_action_pressed("left_click"):
		$Transition.fadeIn()

func _on_Transition_redirect():
	get_tree().change_scene("res://titlescreen/TitleScreen.tscn")
