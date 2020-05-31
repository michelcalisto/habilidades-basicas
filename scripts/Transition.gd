extends Control

signal redirect

func fadeIn():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fade-in")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	$ColorRect.visible = false
	emit_signal("redirect")

func fadeOut():
	$ColorRect.visible = true
	$ColorRect/AnimationPlayer.play("fade-out")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	$ColorRect.visible = false
