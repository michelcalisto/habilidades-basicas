extends ParallaxBackground

var offsets = 0

func _ready():
	set_process(true)
	
func _process(delta):
	offsets -= 100 * delta
	set_scroll_offset(Vector2(offsets, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
