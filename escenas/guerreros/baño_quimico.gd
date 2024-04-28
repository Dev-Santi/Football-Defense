extends "res://escenas/guerreros/guerrero.gd"

var spriteConBañoAbierto = load("res://texturas/ME_Singles_Worksite_48x48_Portable_Toilet_4.png")
var spriteConBañoCerrado = load("res://texturas/ME_Singles_Worksite_48x48_Portable_Toilet_2.png")
var proyectilPala:PackedScene = preload("res://escenas/guerreros/proyectiles/pala.tscn")



func _ready():
	super._ready()



# @Override
func disparar(objetivo:Area2D) -> void:
	super.disparar(objetivo)
	# Instanciar el nuevo proyectil y setear su objetivo
	var nuevoProyectil = proyectilPala.instantiate()
	$Proyectiles.add_child(nuevoProyectil)
	nuevoProyectil.setObjetivo(objetivo)
	# Animar el Sprite
	$Sprite2D.texture = spriteConBañoAbierto
	$"Cerrar puerta del baño".start()

func _on_cerrar_puerta_del_baño_timeout():
	$Sprite2D.texture = spriteConBañoCerrado
