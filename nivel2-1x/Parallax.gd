extends ParallaxBackground

var off_set

func _ready():
	off_set = 0
	set_process(true)

func _process(delta):
	off_set -= 100 * delta
	set_scroll_offset(Vector2(off_set, 0))
