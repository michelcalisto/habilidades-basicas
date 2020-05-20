extends Panel

var contain_slot_item

var code_obj = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	contain_slot_item = false

func set_code_obj(x):
	code_obj = x

func set_slot_item(x):
	contain_slot_item = x
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
