class_name PlayerStateRunning extends PlayerState

static var state_name := "Running"

func get_state_name() -> String:
	return state_name

func exit() -> void:
	player.movement_vector = Vector2.ZERO

func physics_update(delta : float) -> void:
	if player.movement_vector: player.look_vector = player.movement_vector
	
	player.movement_vector = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	
	player.velocity = player.movement_vector * player.movement_speed * delta
	
	if player.movement_vector == Vector2.ZERO:
		state_machine.transition_states("Idle")
	
	elif Input.is_action_just_pressed("Attack"):
		player.velocity = Vector2.ZERO
		state_machine.transition_states("Attack")
