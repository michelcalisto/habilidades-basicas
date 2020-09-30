extends Node

# Information
var information_title = "HABILIDADES BASICAS"
var information_description = "[fill]EL JUEGO DE [wave][color=#ffd948]\"HABILIDADES BASICAS\"[/color][/wave] ESTIMULA ([rainbow freq=0.1 sat=0.5 val=1]LA ATENCION AUDITIVA[/rainbow], [rainbow freq=0.1 sat=0.5 val=1]MEMORIA AUDITIVA[/rainbow] Y [rainbow freq=0.1 sat=0.5 val=1]DISCRIMANACION AUDITIVA[/rainbow]) CON EL FIN DE MEJORAR LA COMPRENSION DE LOS SONIDOS DEL LENGUAJE.[/fill]\n\n[fill]TE INVITAMOS A PROBAR TU CAPACIDAD DE DISCRIMINAR, IDENTIFICAR E INTERPRETAR LOS MENSAJES SONOROS.[/fill]\n\n[center][img=150x180]res://assets/logos/colegio.png[/img]          [img=125x180]res://assets/logos/colegio2.png[/img][/center]"
var information_redirect = "TitleScreen"
# Nivels
var nivels_level = 1
var nivels_score = 0
# Main Theme
var audio = AudioStreamPlayer.new()
var ogg = AudioStreamOGGVorbis.new()
var reverb = AudioBusLayout.new()
#var au = AudioServer.new()
#var ef = AudioEffect.new()
var audio_bus_name = "Master"
var played = false
# Categories
var categorie

func _ready():
	# Childs
	add_child(audio)
	ogg = load("res://assets/sounds/main_theme.ogg")
	ogg.loop = true
	audio.stream = ogg

func play_song():
	played = true
#	var pan = AudioServer.get_bus_effect()
#	var nose = audio.get_bus_index(audio_bus_name)
#	audio.set_bus_volume_db(nose, 1)
	var bus = AudioServer.get_bus_index(audio_bus_name)
	AudioServer.set_bus_volume_db(bus, -30)
	audio.play()

func stop_song():
	played = false
	audio.stop()

# Information
func update_title(title):
	self.information_title = str(title)

func update_description(description):
	self.information_description = str(description)

func update_redirect(redirect):
	self.information_redirect = str(redirect)

# Nivels
func update_level(level):
	self.nivels_level = level

func update_score(score):
	self.nivels_score = score

# Categories
func update_categorie(categorie):
	self.categorie = str(categorie)
