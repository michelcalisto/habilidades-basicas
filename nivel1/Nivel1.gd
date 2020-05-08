extends Node2D

func _ready():
	yield($ColorRect/AnimationPlayer, "animation_finished")
	$ColorRect.visible = false
