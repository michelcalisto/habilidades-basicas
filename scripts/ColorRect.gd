extends ColorRect

func fadeIn():
	self.visible = true
	$AnimationPlayer.play("In")
	yield($AnimationPlayer, "animation_finished")
	self.visible = false

func fadeOut():
	self.visible = true
	$AnimationPlayer.play("Out")
	yield($AnimationPlayer, "animation_finished")
	self.visible = false
