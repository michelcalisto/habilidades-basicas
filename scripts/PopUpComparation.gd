extends Sprite

var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()

func _ready():
	# Childs
	add_child(audio)
	
func update_comparation(x,y):
	$Margin/Sprite.texture = load(str(x))
	$Margin/Sprite/AnimationPlayer.play("scale")
	ogg = load(str(y))
	ogg.loop = false
	audio.stream = ogg
	audio.play()
