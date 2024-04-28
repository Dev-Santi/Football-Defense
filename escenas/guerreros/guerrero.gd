extends StaticBody2D

signal clickeado(body:StaticBody2D)
var estaRojito:bool = false
var seleccionado:bool = false
var contactosConAreasValidas:int = 0
var contactosConGuerreros:int = 0
var cadenciaDeDisparo:float = 0.5
var listoParaDisparar:bool = true
var objetivos:Array = []



func _ready():
	input_pickable = true
	add_to_group("Guerreros")
	$"Cadencia de disparo".wait_time = cadenciaDeDisparo

func _process(_delta):
	if !objetivos.is_empty() && listoParaDisparar:
		disparar(objetivos[0])
	
	if !estaRojito && (contactosConAreasValidas == 0 || contactosConGuerreros > 0):
		ponerRojito()
	if estaRojito && contactosConAreasValidas > 0 && contactosConGuerreros == 0:
		quitarRojito()

func _on_detector_de_enemigos_area_entered(area):
	if area.is_in_group("Enemigos"):
		objetivos.append(area)

func _on_detector_de_enemigos_area_exited(area):
	if area.is_in_group("Enemigos"):
		objetivos.remove_at(objetivos.find(area))

func _on_cadencia_de_disparo_timeout():
	listoParaDisparar = true

func _on_detector_de_area_valida_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("Click"):
		clickeado.emit(self)

func _on_detector_de_area_valida_area_entered(area):
	if area.is_in_group("Areas validas"):
		contactosConAreasValidas += 1

func _on_detector_de_area_valida_area_exited(area):
	if area.is_in_group("Areas validas"):
		contactosConAreasValidas -= 1

func _on_detector_de_area_valida_body_entered(body):
	if body.is_in_group("Guerreros") && body != self:
		contactosConGuerreros += 1

func _on_detector_de_area_valida_body_exited(body):
	if body.is_in_group("Guerreros") && body != self:
		contactosConGuerreros -= 1



func disparar(_objetivo:Area2D) -> void:
	listoParaDisparar = false
	$"Cadencia de disparo".start()

func seleccionar():
	$"Detector de enemigos/Sprite2D".visible = true
	seleccionado = true

func deseleccionar():
	$"Detector de enemigos/Sprite2D".visible = false
	seleccionado = false

func ponerRojito():
	estaRojito = true
	$Sprite2D.modulate = Color.html("ff4e3e")
	$"Detector de enemigos/Sprite2D".visible = false

func quitarRojito():
	estaRojito = false
	$Sprite2D.modulate = Color.html("ffffff")
	$"Detector de enemigos/Sprite2D".visible = true
