class_name State

func _state_init() -> void: # Inicialisacion del estado
	pass

func enter() -> void: # Llamada uando el estado comienza
	pass

func exit() -> void: # Llamada cuando el estado termina
	pass

func update(delta : float) -> void: # process() para el estado
	pass

func physics_update(delta : float) -> void: # physics_process() para el estado
	pass

func get_state_name() -> String:
	push_error("Method get_state_name() must be defined.")
	return ""
