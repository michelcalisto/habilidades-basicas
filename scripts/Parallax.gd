extends ParallaxBackground

var off_set = 0

func _ready():
	set_process(true)

func _process(delta):
	off_set -= 100 * delta
	set_scroll_offset(Vector2(off_set, 0))
