extends Control

#signal redirect

func fadeIn(scene):
	self.visible = true
	$ColorRect/AnimationPlayer.play("fade-in")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	self.visible = false
	get_tree().change_scene("res://scenes/"+scene+".tscn")

	#emit_signal("redirect")

func fadeOut():
	self.visible = true
	$ColorRect/AnimationPlayer.play("fade-out")
	yield($ColorRect/AnimationPlayer, "animation_finished")
	self.visible = false
