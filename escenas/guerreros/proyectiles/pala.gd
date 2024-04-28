extends Area2D

var daño:int = 25
var velocidad:int = 300
var objetivo:Vector2 = Vector2(0,0)

func setVelocidad(nuevaVelocidad:int) -> void:
	velocidad = nuevaVelocidad

func getVelocidad() -> int:
	return velocidad

func setObjetivo(nuevoObjetivo:Area2D) -> void:
	look_at(nuevoObjetivo.global_position)
	objetivo = (nuevoObjetivo.global_position - global_position).normalized()

func getObjetivo() -> Vector2:
	return objetivo



func _ready():
	add_to_group("Proyectiles")

func _process(delta):
	position += getObjetivo() * velocidad * delta



func _on_limite_para_eliminarse_timeout():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("Enemigos"):
		area.quitarVida(daño)
		queue_free()
