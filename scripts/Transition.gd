extends ColorRect

func fadeIn(scene):
	self.visible = true
	$AnimationPlayer.play("fade-in")
	yield($AnimationPlayer, "animation_finished")
	self.visible = false
	get_tree().change_scene("res://scenes/"+scene+".tscn")

func fadeOut():
	self.visible = true
	$AnimationPlayer.play("fade-out")
	yield($AnimationPlayer, "animation_finished")
	self.visible = false
