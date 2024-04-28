extends StaticBody2D

var puedeSeleccionarse:bool = false
var estaSeleccionado:bool = false
var cadenciaDeDisparo:float = 0.5
var listoParaDisparar:bool = true
var objetivos:Array = []
var areasValidas:Array = []
var estaEnZonaValida:bool = false

func setEstaSeleccionado(valor:bool) -> void:
	estaSeleccionado = valor

func setPuedeSeleccionarse(valor:bool) -> void:
	puedeSeleccionarse = valor

func setCadenciaDeDisparo(valor:int) -> void:
	cadenciaDeDisparo = valor
	$"Cadencia de disparo".wait_time = cadenciaDeDisparo

func setListoParaDisparar(valor:bool) -> void:
	listoParaDisparar = valor

func getEstaSeleccionado() -> bool:
	return estaSeleccionado

func getPuedeSeleccionarse() -> bool:
	return puedeSeleccionarse

func getCadenciaDeDisparo() -> float:
	return cadenciaDeDisparo

func getListoParaDisparar() -> bool:
	return listoParaDisparar

func getObjetivoActual():
	return objetivos[0]

func addObjetivo(nuevoObjetivo:Area2D) -> void:
	objetivos.append(nuevoObjetivo)

func delObjetivo(objetivo:Area2D) -> void:
	objetivos.remove_at(objetivos.find(objetivo))



func _ready():
	input_pickable = true
	add_to_group("Guerreros")
	$"Cadencia de disparo".wait_time = cadenciaDeDisparo

func _process(_delta):
	if !objetivos.is_empty() && getListoParaDisparar():
		disparar(getObjetivoActual())
		
	if getPuedeSeleccionarse() && Input.is_action_just_pressed("Click") && estaEnZonaValida:
		setEstaSeleccionado(!getEstaSeleccionado())
	if getEstaSeleccionado():
		global_position = get_global_mouse_position()
		$"Detector de enemigos/Sprite2D".visible = true
	else:
		$"Detector de enemigos/Sprite2D".visible = false

func _on_detector_de_enemigos_area_entered(area):
	if area.is_in_group("Enemigos"):
		addObjetivo(area)

func _on_detector_de_enemigos_area_exited(area):
	if area.is_in_group("Enemigos"):
		delObjetivo(area)

func _on_cadencia_de_disparo_timeout():
	setListoParaDisparar(true)

func _on_mouse_entered():
	setPuedeSeleccionarse(true)

func _on_mouse_exited():
	setPuedeSeleccionarse(false)

func _on_detector_de_area_valida_area_entered(area):
	if area.is_in_group("Areas validas"):
		areasValidas.append(area)
		estaEnZonaValida = true
		$Sprite2D.modulate = Color.html("ffffff")
		$"Detector de enemigos/Sprite2D".modulate = Color.html("ffffff")

func _on_detector_de_area_valida_area_exited(area):
	if area.is_in_group("Areas validas"):
		areasValidas.remove_at(areasValidas.find(area))
		if(areasValidas.is_empty()):
			estaEnZonaValida = false
			$Sprite2D.modulate = Color.html("ff3224")
			$"Detector de enemigos/Sprite2D".modulate = Color.html("ffffff00") 


func disparar(_objetivo:Area2D) -> void:
	setListoParaDisparar(false)
	$"Cadencia de disparo".start()
