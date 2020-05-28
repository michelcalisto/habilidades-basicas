extends Control

func _ready():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fade-out")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	$ColorRect.visible = false
	$TextureRect/ColorRect.visible = true
	$TextureRect/ColorRect/AnimationPlayer.play("fade")
	
	# scroll
	$tween_scroll.interpolate_property($scrolling, "position", Vector2(0, 610), Vector2(0, -280), 20, Tween.TRANS_LINEAR, 0)
	$tween_scroll.start()
	
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		$ColorRect.visible = true
		$ColorRect/AnimationPlayer.play("fade-in")
		yield($ColorRect/AnimationPlayer, "animation_finished")
		$ColorRect.visible = false
		get_tree().change_scene("res://titlescreen/TitleScreen.tscn")

func _on_Control_gui_input(event):
	if event.is_action_pressed("left_click"):
		$ColorRect.visible = true
		$ColorRect/AnimationPlayer.play("fade-in")
		yield($ColorRect/AnimationPlayer, "animation_finished")
		$ColorRect.visible = false
		get_tree().change_scene("res://titlescreen/TitleScreen.tscn")
