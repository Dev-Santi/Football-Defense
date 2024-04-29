extends Node2D

var escenaGallina = preload("res://escenas/enemigos/gallina.tscn")
var cantidadDeGallinas:int = 20
var guerreroSeleccionado:StaticBody2D

func _ready():
	pass

func _process(_delta):
	if guerreroSeleccionado:
		guerreroSeleccionado.global_position = get_global_mouse_position()



# Hacer girar a los enemigos por el camino
func _on_derecha_area_entered(area):
	if(area.is_in_group("Enemigos")):
		area.setDireccion("derecha")

func _on_arriba_area_entered(area):
	if(area.is_in_group("Enemigos")):
		area.setDireccion("arriba")

func _on_abajo_area_entered(area):
	if(area.is_in_group("Enemigos")):
		area.setDireccion("abajo")

# Cuando los enemigos llegan a la meta
func _on_meta_area_entered(area):
	if(area.is_in_group("Enemigos")):
		area.eliminar()

# Cuando se agregan guerreros
func _on_guerreros_child_entered_tree(node):
	node.clickeado.connect(_on_clickeado)

# Cuando se selecciona un guerrero
func _on_clickeado(guerrero):
	if guerreroSeleccionado == guerrero:
		if guerrero.contactosConAreasValidas > 0 && guerrero.contactosConGuerreros == 0:
			guerrero.deseleccionar()
			guerreroSeleccionado = null
	elif !guerreroSeleccionado:
		guerrero.seleccionar()
		guerreroSeleccionado = guerrero


# Cadencia de spawn de gallinas
func _on_spawn_de_gallinas_timeout():
	if cantidadDeGallinas > 0:
		spawnearGallina()

func spawnearGallina() -> void:
	cantidadDeGallinas -= 1
	var nuevaGallina = escenaGallina.instantiate()
	$Enemigos.add_child(nuevaGallina)
	$Enemigos.move_child(nuevaGallina, 0)
	$"Spawn de gallinas".wait_time = generarTiempoRandom()
	$"Spawn de gallinas".start()

var rng = RandomNumberGenerator.new()
func generarTiempoRandom() -> float:
	return rng.randf_range(0.3, 1)
	
