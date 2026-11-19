extends InteractArea

var is_active : bool = false

@export var jugador : Player

func on_interact() -> void:
	set_deferred("monitorable", false)
	if jugador.llave_1 && jugador.llave_2 && jugador.llave_3:
		SignalBus.emit_signal("start_boss")
	else:
		SignalBus.emit_signal("open_dialogue", "La puerta esta cerrada, parece que necesitas 3 llaves para habrila.")
		is_active = true

func _unhandled_input(event) -> void:
	if is_active:
		if Input.is_action_just_pressed("Attack") || Input.is_action_just_pressed("Interact"):
				SignalBus.emit_signal("close_dialogue")
				is_active = false
				set_deferred("monitorable", true)
