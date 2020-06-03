extends Control

var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var audiobtn = AudioStreamPlayer.new()
var oggbtn = AudioStreamOGGVorbis.new()

func _ready():
	# Transition
	$Transition.fadeOut()
	yield($Transition/AnimationPlayer, "animation_finished")
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
	Global.update_title("ATENCION AUDITIVA")
	Global.update_description("[fill]EN ESTE JUEGO TENDRAS QUE ESTAR MUY ATENTO/A, PORQUE TIENES QUE ESCUCHAR SONIDOS DE ANIMALES. ESTE JUEGO CONSTA DE TRES ETAPAS, LAS CUALES IRAN AUMENTANDO SU DIFICULTAD A MEDIDA QUE AVANCES POR LOS NIVELES. SI OBTIENES UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL O SUPERIOR[/rainbow] A [color=#ffd948]CUATRO PUNTOS[/color] EN CADA FASE PASAS A LA SIGUIENTE, SINO LO PUEDES VOLVER A INTENTAR LAS VECES QUE QUIERAS.[/fill]")
	Global.update_redirect("Nivel1")
	$Transition.fadeIn("Information")

func _on_Nivel2_pressed():
	audiobtn.play()
	Global.update_title("MEMORIA AUDITIVA")
	Global.update_description("[fill]EL JUEGO CONSTA DE CUATRO ETAPAS. A MEDIDA QUE VAS AVANZANDO ESTE INCREMENTA EN DIFICULTAD. HAY QUE COLOCAR MUCHA ATENCION AL ORDEN EN EL QUE ESCUCHES LOS SONIDOS, PORQUE DEBERAS [color=#ffd948]ORDENAR[/color] LAS IMAGENES POSTERIOR A ESTO. SI PRESENTAS UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL[/rainbow] A [color=#ffd948]DOS[/color] EN CADA ETAPA PASAS A LA SIGUIENTE, SINO LO PUEDES VOLVER A INTERNTAR LAS VECES QUE QUIERAS.[/fill]")
	Global.update_redirect("Nivel2")
	$Transition.fadeIn("Information")

func _on_Nivel3_pressed():
	audiobtn.play()
	Global.update_title("DISCRIMIMACION AUDITIVA")
	Global.update_description("[fill]EL JUEGO CONSTA DE UNA ETAPA. EN LA CUAL ESCUCHARAS DOS PALABRAS, DEBES COLOCAR MUCHA ATENCION E IDENTIFICAR SI LAS PALABRAS SUENAN [color=#ffd948]IGUAL[/color] ([img=25x25]res://assets/icons/igual.png[/img]) O [color=#ffd948]DIFERENTE[/color] ([img=25x25]res://assets/icons/diffss.png[/img]). SI OBTIENES UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL O SUPERIOR[/rainbow] A [color=#ffd948]SIETE[/color] GANAS.[/fill]")
	Global.update_redirect("Nivel3")
	$Transition.fadeIn("Information")

func _on_Credits_pressed():
	audiobtn.play()
	$Transition.fadeIn("Credits")
