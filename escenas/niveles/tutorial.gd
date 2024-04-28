extends Node2D

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
	else:
		guerrero.seleccionar()
		guerreroSeleccionado = guerrero
