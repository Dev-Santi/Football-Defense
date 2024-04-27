extends Node2D

func _ready():
	pass 

func _process(_delta):
	pass





func _on_derecha_area_entered(area):
	if(area.is_in_group("Enemigos")):
		area.setDireccion("derecha")

func _on_arriba_area_entered(area):
	if(area.is_in_group("Enemigos")):
		area.setDireccion("arriba")

func _on_abajo_area_entered(area):
	if(area.is_in_group("Enemigos")):
		area.setDireccion("abajo")
