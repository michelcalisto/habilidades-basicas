extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#$ColorRect.visible = true
	#$ColorRect/AnimationPlayer.play("fadein")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	$ColorRect.visible = false
	#get_tree().change_scene("res://nivel1/Nivel1.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
