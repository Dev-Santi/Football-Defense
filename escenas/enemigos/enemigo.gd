extends Area2D

var velocidad:int = 150
var direccion:String = "abajo"

func getVelocidad():
	return velocidad

func getDireccion():
	return direccion

func setDireccion(nuevaDireccion:String):
	direccion = nuevaDireccion

func setVelocidad(nuevaVelocidad:int):
	velocidad = nuevaVelocidad




func _ready():
	add_to_group("Enemigos")

func _process(delta):
	if direccion == "derecha":
		position += Vector2(velocidad * delta,0)
	elif direccion == "abajo":
		position += Vector2(0, velocidad * delta)
	elif direccion == "izquierda":
		position += Vector2(-1 * velocidad * delta,0)
	else:
		position += Vector2(0, -1 * velocidad * delta)
