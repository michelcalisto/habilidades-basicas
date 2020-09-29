extends Control

var audiobtn = AudioStreamPlayer.new()
var oggbtn = AudioStreamOGGVorbis.new()
# Buttons
var main = true
var nivel1 = false
var nivel2 = false
var nivel2_1 = false
var nivel2_2 = false
var nivel2_3 = false

func _ready():
	if Global.played == false:
		Global.play_song()
	menu()
	# Transition
	$Transition.fadeOut()
	yield($Transition/AnimationPlayer, "animation_finished")
	# Childs
	add_child(audiobtn)
	oggbtn = load("res://assets/sounds/click.ogg")
	oggbtn.loop = false
	audiobtn.stream = oggbtn

func menu():
	if main == true:
		$VBox/Margin2/VBox/Margin1/Nivel1.show()
		$VBox/Margin2/VBox/Margin1/Atencion1.hide()
		$VBox/Margin2/VBox/Margin1/Atencion2.hide()
		$VBox/Margin2/VBox/Margin1/Intensidad.hide()
		$VBox/Margin2/VBox/Margin1/Categories.hide()
		$VBox/Margin2/VBox/Margin1/Categories2.hide()
		
		$VBox/Margin2/VBox/Margin2.show()
		$VBox/Margin2/VBox/Margin2/Nivel2.show()
		$VBox/Margin2/VBox/Margin2/Memoria1.hide()
		$VBox/Margin2/VBox/Margin2/Memoria2.hide()
		$VBox/Margin2/VBox/Margin2/Duracion.hide()
		
		$VBox/Margin2/VBox/Margin3/Discriminacion1.hide()
		$VBox/Margin2/VBox/Margin3/Discriminacion2.hide()
		
		$VBox/Margin2/VBox/Margin4/Credits.show()
		$VBox/Margin2/VBox/Margin4/Regresar1.hide()
		$VBox/Margin2/VBox/Margin4/Regresar2.hide()
		$VBox/Margin2/VBox/Margin4/Regresar2_1.hide()
		$VBox/Margin2/VBox/Margin4/Regresar2_2.hide()
		$VBox/Margin2/VBox/Margin4/Regresar2_3.hide()
	else:
		if nivel1 == true:
			$VBox/Margin2/VBox/Margin1/Nivel1.hide()
			$VBox/Margin2/VBox/Margin1/Atencion1.show()
			$VBox/Margin2/VBox/Margin1/Atencion2.hide()
			$VBox/Margin2/VBox/Margin1/Intensidad.hide()
			$VBox/Margin2/VBox/Margin1/Categories.hide()
			$VBox/Margin2/VBox/Margin1/Categories2.hide()
			
			$VBox/Margin2/VBox/Margin2.show()
			$VBox/Margin2/VBox/Margin2/Nivel2.hide()
			$VBox/Margin2/VBox/Margin2/Memoria1.show()
			$VBox/Margin2/VBox/Margin2/Memoria2.hide()
			$VBox/Margin2/VBox/Margin2/Duracion.hide()
			
			$VBox/Margin2/VBox/Margin3/Discriminacion1.show()
			$VBox/Margin2/VBox/Margin3/Discriminacion2.hide()
			
			$VBox/Margin2/VBox/Margin4/Credits.hide()
			$VBox/Margin2/VBox/Margin4/Regresar1.show()
			$VBox/Margin2/VBox/Margin4/Regresar2.hide()
			$VBox/Margin2/VBox/Margin4/Regresar2_1.hide()
			$VBox/Margin2/VBox/Margin4/Regresar2_2.hide()
			$VBox/Margin2/VBox/Margin4/Regresar2_3.hide()
		else: 
			if nivel2 == true:
				$VBox/Margin2/VBox/Margin1/Nivel1.hide()
				$VBox/Margin2/VBox/Margin1/Atencion1.hide()
				$VBox/Margin2/VBox/Margin1/Atencion2.show()
				$VBox/Margin2/VBox/Margin1/Intensidad.hide()
				$VBox/Margin2/VBox/Margin1/Categories.hide()
				$VBox/Margin2/VBox/Margin1/Categories2.hide()
				
				$VBox/Margin2/VBox/Margin2.show()
				$VBox/Margin2/VBox/Margin2/Nivel2.hide()
				$VBox/Margin2/VBox/Margin2/Memoria1.hide()
				$VBox/Margin2/VBox/Margin2/Memoria2.show()
				$VBox/Margin2/VBox/Margin2/Duracion.hide()
				
				$VBox/Margin2/VBox/Margin3/Discriminacion1.hide()
				$VBox/Margin2/VBox/Margin3/Discriminacion2.show()
				
				$VBox/Margin2/VBox/Margin4/Credits.hide()
				$VBox/Margin2/VBox/Margin4/Regresar1.hide()
				$VBox/Margin2/VBox/Margin4/Regresar2.show()
				$VBox/Margin2/VBox/Margin4/Regresar2_1.hide()
				$VBox/Margin2/VBox/Margin4/Regresar2_2.hide()
				$VBox/Margin2/VBox/Margin4/Regresar2_3.hide()
			else: 
				if nivel2_3 == true:
					$VBox/Margin2/VBox/Margin1/Nivel1.hide()
					$VBox/Margin2/VBox/Margin1/Atencion1.hide()
					$VBox/Margin2/VBox/Margin1/Atencion2.hide()
					$VBox/Margin2/VBox/Margin1/Intensidad.show()
					$VBox/Margin2/VBox/Margin1/Categories.hide()
					$VBox/Margin2/VBox/Margin1/Categories2.hide()
					
					$VBox/Margin2/VBox/Margin2.show()
					$VBox/Margin2/VBox/Margin2/Nivel2.hide()
					$VBox/Margin2/VBox/Margin2/Memoria1.hide()
					$VBox/Margin2/VBox/Margin2/Memoria2.hide()
					$VBox/Margin2/VBox/Margin2/Duracion.show()
					
					$VBox/Margin2/VBox/Margin3/Discriminacion1.hide()
					$VBox/Margin2/VBox/Margin3/Discriminacion2.hide()
					
					$VBox/Margin2/VBox/Margin4/Credits.hide()
					$VBox/Margin2/VBox/Margin4/Regresar1.hide()
					$VBox/Margin2/VBox/Margin4/Regresar2.hide()
					$VBox/Margin2/VBox/Margin4/Regresar2_1.hide()
					$VBox/Margin2/VBox/Margin4/Regresar2_2.hide()
					$VBox/Margin2/VBox/Margin4/Regresar2_3.show()
				else: 
					if nivel2_1 == true:
						$VBox/Margin2/VBox/Margin1/Nivel1.hide()
						$VBox/Margin2/VBox/Margin1/Atencion1.hide()
						$VBox/Margin2/VBox/Margin1/Atencion2.hide()
						$VBox/Margin2/VBox/Margin1/Intensidad.hide()
						$VBox/Margin2/VBox/Margin1/Categories.show()
						$VBox/Margin2/VBox/Margin1/Categories2.hide()
						
						$VBox/Margin2/VBox/Margin2.hide()
						$VBox/Margin2/VBox/Margin2/Nivel2.hide()
						$VBox/Margin2/VBox/Margin2/Memoria1.hide()
						$VBox/Margin2/VBox/Margin2/Memoria2.hide()
						$VBox/Margin2/VBox/Margin2/Duracion.hide()
						
						$VBox/Margin2/VBox/Margin3/Discriminacion1.hide()
						$VBox/Margin2/VBox/Margin3/Discriminacion2.hide()
						
						$VBox/Margin2/VBox/Margin4/Credits.hide()
						$VBox/Margin2/VBox/Margin4/Regresar1.hide()
						$VBox/Margin2/VBox/Margin4/Regresar2.hide()
						$VBox/Margin2/VBox/Margin4/Regresar2_1.show()
						$VBox/Margin2/VBox/Margin4/Regresar2_2.hide()
						$VBox/Margin2/VBox/Margin4/Regresar2_3.hide()
					else: 
						if nivel2_2 == true:
							$VBox/Margin2/VBox/Margin1/Nivel1.hide()
							$VBox/Margin2/VBox/Margin1/Atencion1.hide()
							$VBox/Margin2/VBox/Margin1/Atencion2.hide()
							$VBox/Margin2/VBox/Margin1/Intensidad.hide()
							$VBox/Margin2/VBox/Margin1/Categories.hide()
							$VBox/Margin2/VBox/Margin1/Categories2.show()
							
							$VBox/Margin2/VBox/Margin2.hide()
							$VBox/Margin2/VBox/Margin2/Nivel2.hide()
							$VBox/Margin2/VBox/Margin2/Memoria1.hide()
							$VBox/Margin2/VBox/Margin2/Memoria2.hide()
							$VBox/Margin2/VBox/Margin2/Duracion.hide()
							
							$VBox/Margin2/VBox/Margin3/Discriminacion1.hide()
							$VBox/Margin2/VBox/Margin3/Discriminacion2.hide()
							
							$VBox/Margin2/VBox/Margin4/Credits.hide()
							$VBox/Margin2/VBox/Margin4/Regresar1.hide()
							$VBox/Margin2/VBox/Margin4/Regresar2.hide()
							$VBox/Margin2/VBox/Margin4/Regresar2_1.hide()
							$VBox/Margin2/VBox/Margin4/Regresar2_2.show()
							$VBox/Margin2/VBox/Margin4/Regresar2_3.hide()

func _on_Nivel1_pressed():
	audiobtn.play()
	main = false
	nivel1 = true
	nivel2 = false
	nivel2_1 = false
	nivel2_2 = false
	nivel2_3 = false
	$ColorRect.fadeIn()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	menu()
	$ColorRect.fadeOut()
	yield($ColorRect/AnimationPlayer, "animation_finished")

func _on_Atencion1_pressed():
	audiobtn.play()
	Global.update_title("ATENCION AUDITIVA")
	Global.update_description("[fill]EN ESTE JUEGO TENDRAS QUE ESTAR MUY ATENTO/A, PORQUE TIENES QUE ESCUCHAR SONIDOS DE ANIMALES. ESTE JUEGO CONSTA DE TRES ETAPAS, LAS CUALES IRAN AUMENTANDO SU DIFICULTAD A MEDIDA QUE AVANCES POR LOS NIVELES. SI OBTIENES UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL O SUPERIOR[/rainbow] A [color=#ffd948]CUATRO PUNTOS[/color] EN CADA FASE PASAS A LA SIGUIENTE, SINO LO PUEDES VOLVER A INTENTAR LAS VECES QUE QUIERAS.[/fill]")
	Global.update_redirect("nivel1/Nivel1")
	$Transition.fadeIn("Information")
	Global.stop_song()

func _on_Atencion2_pressed():
	audiobtn.play()
	main = false
	nivel1 = false
	nivel2 = false
	nivel2_1 = true
	nivel2_2 = false
	nivel2_3 = false
	$ColorRect.fadeIn()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	menu()
	$ColorRect.fadeOut()
	yield($ColorRect/AnimationPlayer, "animation_finished")

func _on_Intensidad_pressed():
	audiobtn.play()
	Global.update_title("INTENSIDAD")
	Global.update_description("[fill]EL JUEGO CONSTA DE DOS ETAPAS. EN LAS CUALES ESCUCHARAS DOS SONIDOS, DEBES COLOCAR MUCHA ATENCION E IDENTIFICAR SI LOS SONIDOS TIENEN [color=#ffd948]IGUAL[/color] ([img=25x25]res://assets/icons/igual.png[/img]) O [color=#ffd948]DIFERENTE[/color] ([img=25x25]res://assets/icons/diffss.png[/img]) INTENSIDAD. SI PRESENTAS UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL O SUPERIOR[/rainbow] A [color=#ffd948]SIETE[/color] EN CADA ETAPA PASAS A LA SIGUIENTE, SINO LO PUEDES VOLVER A INTERNTAR LAS VECES QUE QUIERAS.[/fill]")
	Global.update_redirect("nivel2/nivel2_3/Nivel1")
	$Transition.fadeIn("Information")
	Global.stop_song()

func _on_Nivel2_pressed():
	audiobtn.play()
	main = false
	nivel1 = false
	nivel2 = true
	nivel2_1 = false
	nivel2_2 = false
	nivel2_3 = false
	$ColorRect.fadeIn()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	menu()
	$ColorRect.fadeOut()
	yield($ColorRect/AnimationPlayer, "animation_finished")

func _on_Memoria1_pressed():
	audiobtn.play()
	Global.update_title("MEMORIA AUDITIVA")
	Global.update_description("[fill]EL JUEGO CONSTA DE CUATRO ETAPAS. A MEDIDA QUE VAS AVANZANDO ESTE INCREMENTA EN DIFICULTAD. HAY QUE COLOCAR MUCHA ATENCION AL ORDEN EN EL QUE ESCUCHES LOS SONIDOS, PORQUE DEBERAS [color=#ffd948]ORDENAR[/color] LAS IMAGENES POSTERIOR A ESTO. SI PRESENTAS UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL[/rainbow] A [color=#ffd948]DOS[/color] EN CADA ETAPA PASAS A LA SIGUIENTE, SINO LO PUEDES VOLVER A INTERNTAR LAS VECES QUE QUIERAS.[/fill]")
	Global.update_redirect("nivel1/Nivel2")
	$Transition.fadeIn("Information")
	Global.stop_song()


func _on_Memoria2_pressed():
	audiobtn.play()
	main = false
	nivel1 = false
	nivel2 = false
	nivel2_1 = false
	nivel2_2 = true
	nivel2_3 = false
	$ColorRect.fadeIn()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	menu()
	$ColorRect.fadeOut()
	yield($ColorRect/AnimationPlayer, "animation_finished")

func _on_Duracion_pressed():
	audiobtn.play()
	Global.update_title("DURACION")
	Global.update_description("[fill]EL JUEGO CONSTA DE DOS ETAPAS. EN LAS CUALES ESCUCHARAS DOS SONIDOS, DEBES COLOCAR MUCHA ATENCION E IDENTIFICAR SI LOS SONIDOS TIENEN [color=#ffd948]IGUAL[/color] ([img=25x25]res://assets/icons/igual.png[/img]) O [color=#ffd948]DIFERENTE[/color] ([img=25x25]res://assets/icons/diffss.png[/img]) DURACION. SI PRESENTAS UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL O SUPERIOR[/rainbow] A [color=#ffd948]SIETE[/color] EN CADA ETAPA PASAS A LA SIGUIENTE, SINO LO PUEDES VOLVER A INTERNTAR LAS VECES QUE QUIERAS.[/fill]")
	Global.update_redirect("nivel2/nivel2_3/Nivel2")
	$Transition.fadeIn("Information")
	Global.stop_song()

func _on_Discriminacion1_pressed():
	audiobtn.play()
	Global.update_title("DISCRIMIMACION AUDITIVA")
	Global.update_description("[fill]EL JUEGO CONSTA DE UNA ETAPA. EN LA CUAL ESCUCHARAS DOS PALABRAS, DEBES COLOCAR MUCHA ATENCION E IDENTIFICAR SI LAS PALABRAS SUENAN [color=#ffd948]IGUAL[/color] ([img=25x25]res://assets/icons/igual.png[/img]) O [color=#ffd948]DIFERENTE[/color] ([img=25x25]res://assets/icons/diffss.png[/img]). SI OBTIENES UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL O SUPERIOR[/rainbow] A [color=#ffd948]SIETE[/color] GANAS.[/fill]")
	Global.update_redirect("nivel1/Nivel3")
	$Transition.fadeIn("Information")
	Global.stop_song()

func _on_Discriminacion2_pressed():
	audiobtn.play()
	main = false
	nivel1 = false
	nivel2 = false
	nivel2_1 = false
	nivel2_2 = false
	nivel2_3 = true
	$ColorRect.fadeIn()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	menu()
	$ColorRect.fadeOut()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	
func _on_Credits_pressed():
	audiobtn.play()
	$Transition.fadeIn("Credits")

func _on_Regresar1_pressed():
	audiobtn.play()
	main = true
	nivel1 = false
	nivel2 = false
	nivel2_1 = false
	nivel2_2 = false
	nivel2_3 = false
	$ColorRect.fadeIn()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	menu()
	$ColorRect.fadeOut()
	yield($ColorRect/AnimationPlayer, "animation_finished")

func _on_Regresar2_pressed():
	audiobtn.play()
	main = true
	nivel1 = false
	nivel2 = false
	nivel2_1 = false
	nivel2_2 = false
	nivel2_3 = false
	$ColorRect.fadeIn()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	menu()
	$ColorRect.fadeOut()
	yield($ColorRect/AnimationPlayer, "animation_finished")

func _on_Regresar2_1_pressed():
	audiobtn.play()
	main = false
	nivel1 = false
	nivel2 = true
	nivel2_1 = false
	nivel2_2 = false
	nivel2_3 = false
	$ColorRect.fadeIn()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	menu()
	$ColorRect.fadeOut()
	yield($ColorRect/AnimationPlayer, "animation_finished")

func _on_Regresar2_2_pressed():
	audiobtn.play()
	main = false
	nivel1 = false
	nivel2 = true
	nivel2_1 = false
	nivel2_2 = false
	nivel2_3 = false
	$ColorRect.fadeIn()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	menu()
	$ColorRect.fadeOut()
	yield($ColorRect/AnimationPlayer, "animation_finished")

func _on_Regresar2_3_pressed():
	audiobtn.play()
	main = false
	nivel1 = false
	nivel2 = true
	nivel2_1 = false
	nivel2_2 = false
	nivel2_3 = false
	$ColorRect.fadeIn()
	yield($ColorRect/AnimationPlayer, "animation_finished")
	menu()
	$ColorRect.fadeOut()
	yield($ColorRect/AnimationPlayer, "animation_finished")

func _on_Animals_pressed():
	audiobtn.play()
	Global.update_title("ATENCION AUDITIVA")
	Global.update_description("[fill]EN ESTE JUEGO TENDRAS QUE ESTAR MUY ATENTO/A, PORQUE TIENES QUE ESCUCHAR SONIDOS. ESTE JUEGO CONSTA DE CUATRO ETAPAS, LAS CUALES IRAN AUMENTANDO SU DIFICULTAD A MEDIDA QUE AVANCES POR LOS NIVELES. [rainbow freq=0.1 sat=0.5 val=1]ACIERTA A CADA SONIDO QUE ESCUCHES[/rainbow] Y COMPLETARAS CON EXITO ESTA ACTIVIDAD. SI TE EQUIVOCAS, NO TE PREOCUPES, LO PUEDES VOLVER A INTENTAR LAS VECES QUE QUIERAS.[/fill]")
	Global.update_redirect("nivel2/Nivel1")
	Global.update_categorie("animals")
	$Transition.fadeIn("Information")
	Global.stop_song()

func _on_Instruments_pressed():
	audiobtn.play()
	Global.update_title("ATENCION AUDITIVA")
	Global.update_description("[fill]EN ESTE JUEGO TENDRAS QUE ESTAR MUY ATENTO/A, PORQUE TIENES QUE ESCUCHAR SONIDOS. ESTE JUEGO CONSTA DE CUATRO ETAPAS, LAS CUALES IRAN AUMENTANDO SU DIFICULTAD A MEDIDA QUE AVANCES POR LOS NIVELES. [rainbow freq=0.1 sat=0.5 val=1]ACIERTA A CADA SONIDO QUE ESCUCHES[/rainbow] Y COMPLETARAS CON EXITO ESTA ACTIVIDAD. SI TE EQUIVOCAS, NO TE PREOCUPES, LO PUEDES VOLVER A INTENTAR LAS VECES QUE QUIERAS.[/fill]")
	Global.update_redirect("nivel2/Nivel1")
	Global.update_categorie("instrumentos")
	$Transition.fadeIn("Information")
	Global.stop_song()

func _on_Animals2_pressed():
	audiobtn.play()
	Global.update_title("MEMORIA AUDITIVA")
	Global.update_description("[fill]EL JUEGO CONSTA DE CUATRO ETAPAS. A MEDIDA QUE VAS AVANZANDO ESTE INCREMENTA EN DIFICULTAD. HAY QUE COLOCAR MUCHA ATENCION AL ORDEN EN EL QUE ESCUCHES LOS SONIDOS, PORQUE DEBERAS [color=#ffd948]ORDENAR[/color] LAS IMAGENES POSTERIOR A ESTO. SI PRESENTAS UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL[/rainbow] A [color=#ffd948]DOS[/color] EN CADA ETAPA PASAS A LA SIGUIENTE, SINO LO PUEDES VOLVER A INTERNTAR LAS VECES QUE QUIERAS.[/fill]")
	Global.update_redirect("nivel2/Nivel2")
	Global.update_categorie("animals")
	$Transition.fadeIn("Information")
	Global.stop_song()

func _on_Instruments2_pressed():
	audiobtn.play()
	Global.update_title("MEMORIA AUDITIVA")
	Global.update_description("[fill]EL JUEGO CONSTA DE CUATRO ETAPAS. A MEDIDA QUE VAS AVANZANDO ESTE INCREMENTA EN DIFICULTAD. HAY QUE COLOCAR MUCHA ATENCION AL ORDEN EN EL QUE ESCUCHES LOS SONIDOS, PORQUE DEBERAS [color=#ffd948]ORDENAR[/color] LAS IMAGENES POSTERIOR A ESTO. SI PRESENTAS UN PUNTAJE [rainbow freq=0.1 sat=0.5 val=1]IGUAL[/rainbow] A [color=#ffd948]DOS[/color] EN CADA ETAPA PASAS A LA SIGUIENTE, SINO LO PUEDES VOLVER A INTERNTAR LAS VECES QUE QUIERAS.[/fill]")
	Global.update_redirect("nivel2/Nivel2")
	Global.update_categorie("instrumentos")
	$Transition.fadeIn("Information")
	Global.stop_song()
