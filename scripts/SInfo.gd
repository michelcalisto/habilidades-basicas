extends Node

var title = "HABILIDADES BASICAS"
var description = "[center]EL JUEGO DE [wave][color=#ffd948]\"HABILIDADES BASICAS\"[/color][/wave] ESTIMULA ([rainbow freq=0.1 sat=0.5 val=1]LA ATENCION AUDITIVA[/rainbow], [rainbow freq=0.1 sat=0.5 val=1]MEMORIA AUDITIVA[/rainbow] Y [rainbow freq=0.1 sat=0.5 val=1]DISCRIMANACION AUDITIVA[/rainbow]) CON EL FIN DE FACILITAR Y MEJORAR EL PROCESO DE ADQUISICION DE LA LECTURA.[/center]\n\n[center]DESTINADO A NIÑOS DESDE 4 AÑOS.[/center]\n\n\n[center][img=150x180]res://assets/logos/colegio.png[/img][/center]"
var redirect = "TitleScreen"

func update_title(title):
	self.title = str(title)

func update_description(description):
	self.description = str(description)

func update_redirect(redirect):
	self.redirect = str(redirect)
