extends Control

func _ready():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fade-out")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	$ColorRect.visible = false
	$Background/ColorRect.visible = true
	$Background/ColorRect/AnimationPlayer.play("fade")

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		$ColorRect.visible = true
		$ColorRect/AnimationPlayer.play("fade-in")
		yield($ColorRect/AnimationPlayer, "animation_finished")
		$ColorRect.visible = false
		get_tree().change_scene("res://title-screen/TitleScreen.tscn")

func _on_Control_gui_input(event):
	if event.is_action_pressed("left_click"):
		$ColorRect.visible = true
		$ColorRect/AnimationPlayer.play("fade-in")
		yield($ColorRect/AnimationPlayer, "animation_finished")
		$ColorRect.visible = false
		get_tree().change_scene("res://title-screen/TitleScreen.tscn")
