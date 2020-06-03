extends Node

# Information
var information_title = "HABILIDADES BASICAS"
var information_description = "[center]EL JUEGO DE [wave][color=#ffd948]\"HABILIDADES BASICAS\"[/color][/wave] ESTIMULA ([rainbow freq=0.1 sat=0.5 val=1]LA ATENCION AUDITIVA[/rainbow], [rainbow freq=0.1 sat=0.5 val=1]MEMORIA AUDITIVA[/rainbow] Y [rainbow freq=0.1 sat=0.5 val=1]DISCRIMANACION AUDITIVA[/rainbow]) CON EL FIN DE FACILITAR Y MEJORAR EL PROCESO DE ADQUISICION DE LA LECTURA.[/center]\n\n[center]DESTINADO A NIÑOS DESDE 4 AÑOS.[/center]\n\n\n[center][img=150x180]res://assets/logos/colegio.png[/img][/center]"
var information_redirect = "TitleScreen"
# Nivel 1
var nivel1_level = 1
var nivel1_score = 0

# Information
func update_title(title):
	self.information_title = str(title)

func update_description(description):
	self.information_description = str(description)

func update_redirect(redirect):
	self.information_redirect = str(redirect)

# Nivel 1
func update_nivel1_level(level):
	self.nivel1_level = level

func update_nivel1_score(score):
	self.nivel1_score = score
