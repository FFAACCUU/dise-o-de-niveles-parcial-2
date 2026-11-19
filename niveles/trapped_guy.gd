extends InteractArea

@export_multiline() var dialogue_array : Array[String]

var interact_number : int = 0

var is_active : bool = false

@export var jugador : Player

func on_interact() -> void:
	set_deferred("monitorable", false)
	SignalBus.emit_signal("open_dialogue", dialogue_array[interact_number])
	if interact_number < dialogue_array.size() - 1:
		interact_number += 1
	is_active = true

func _unhandled_input(event) -> void:
	if is_active:
		if Input.is_action_just_pressed("Attack") || Input.is_action_just_pressed("Interact"):
			if interact_number < 2:
				on_interact()
				jugador.llave_1 = true
			else:
				SignalBus.emit_signal("close_dialogue")
				is_active = false
				set_deferred("monitorable", true)
