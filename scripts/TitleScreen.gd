extends Control

var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var audiobtn = AudioStreamPlayer.new()
var oggbtn = AudioStreamOGGVorbis.new()

func _ready():
	$Transition.fadeOut()
	# Childs
	add_child(audio)
	add_child(audiobtn)
	ogg = load("res://assets/sounds/title.ogg")
	oggbtn = load("res://assets/sounds/click.ogg")
	ogg.loop = true
	oggbtn.loop = false
	audio.stream = ogg
	audiobtn.stream = oggbtn
	audio.play()

func _on_Nivel1_pressed():
	audiobtn.play()
	SInfo.update_title("ATENCION AUDITIVA")
	SInfo.update_description("[fill]EN ESTE JUEGO TENDRAS QUE ESTAR MUY ATENTO/A, PORQUE TIENES QUE ESCUCHAR SONIDOS DE ANIMALES. ESTE JUEGO CONSTA DE TRES ETAPAS, LAS CUALES IRAN AUMENTANDO SU DIFICULTAD A MEDIDA QUE AVANCES POR LOS NIVELES. SI OBTIENES UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL O SUPERIOR[/rainbow] A [color=#ffd948]CUATRO PUNTOS[/color] EN CADA FASE PASAS A LA SIGUIENTE, SINO LO PUEDES VOLVER A INTENTAR LAS VECES QUE QUIERAS.[/fill]")
	SInfo.update_redirect("Nivel1")
	$Transition.fadeIn("Information")

func _on_Nivel2_pressed():
	audiobtn.play()
	SInfo.update_title("ATENCION AUDITIVA")
	SInfo.update_description("[fill]EN ESTE JUEGO TENDRAS QUE ESTAR MUY ATENTO/A, PORQUE TIENES QUE ESCUCHAR SONIDOS DE ANIMALES. ESTE JUEGO CONSTA DE TRES ETAPAS, LAS CUALES IRAN AUMENTANDO SU DIFICULTAD A MEDIDA QUE AVANCES POR LOS NIVELES. SI OBTIENES UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL O SUPERIOR[/rainbow] A [color=#ffd948]CUATRO PUNTOS[/color] EN CADA FASE PASAS A LA SIGUIENTE, SINO LO PUEDES VOLVER A INTENTAR LAS VECES QUE QUIERAS.[/fill]")
	SInfo.update_redirect("Nivel1")
	$Transition.fadeIn("Nivel2")

func _on_Nivel3_pressed():
	audiobtn.play()
	SInfo.update_title("ATENCION AUDITIVA")
	SInfo.update_description("[fill]EN ESTE JUEGO TENDRAS QUE ESTAR MUY ATENTO/A, PORQUE TIENES QUE ESCUCHAR SONIDOS DE ANIMALES. ESTE JUEGO CONSTA DE TRES ETAPAS, LAS CUALES IRAN AUMENTANDO SU DIFICULTAD A MEDIDA QUE AVANCES POR LOS NIVELES. SI OBTIENES UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL O SUPERIOR[/rainbow] A [color=#ffd948]CUATRO PUNTOS[/color] EN CADA FASE PASAS A LA SIGUIENTE, SINO LO PUEDES VOLVER A INTENTAR LAS VECES QUE QUIERAS.[/fill]")
	SInfo.update_redirect("Nivel1")
	$Transition.fadeIn("Nivel3")

func _on_Credits_pressed():
	audiobtn.play()
	$Transition.fadeIn("Credits")
