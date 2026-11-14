class_name PlayerStateIdle extends PlayerState

static var state_name := "Idle"

func get_state_name() -> String:
	return state_name

func update(delta : float) -> void:
	if Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized() != Vector2.ZERO:
		state_machine.transition_states("Running")
	
	if Input.is_action_just_pressed("Attack"):
		state_machine.transition_states("Attack")
