extends StaticBody2D

func _ready():
	add_to_group("Guerreros")

func _process(_delta):
	pass

func _on_detector_de_enemigos_area_entered(area):
	if area.is_in_group("Enemigos"):
		print("Entro")
