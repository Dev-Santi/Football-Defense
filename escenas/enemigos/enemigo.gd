extends Area2D

var velocidad:int = 150
var direccion:String = "abajo"
var vida = 100

func getVida() -> int:
	return vida

func getVelocidad() -> int:
	return velocidad

func getDireccion() -> String:
	return direccion

func setDireccion(nuevaDireccion:String) -> void:
	direccion = nuevaDireccion

func setVelocidad(nuevaVelocidad:int) -> void:
	velocidad = nuevaVelocidad
	
func setVida(nuevaVida) -> void:
	vida = nuevaVida



func _ready():
	add_to_group("Enemigos")

func _process(delta):
	# Mostrar la vida o eliminar enemigo
	if(getVida() <= 0):
		eliminar()
	$Label.text = str(getVida())
	
	# Mover al enemigo
	if direccion == "derecha":
		position += Vector2(velocidad * delta,0)
	elif direccion == "abajo":
		position += Vector2(0, velocidad * delta)
	elif direccion == "izquierda":
		position += Vector2(-1 * velocidad * delta,0)
	else:
		position += Vector2(0, -1 * velocidad * delta)



func eliminar() -> void:
	queue_free()

func quitarVida(cantidad:int) -> void:
	setVida(getVida() - cantidad)
