class_name PlayerStateRunning extends PlayerState

static var state_name := "Running"

func get_state_name() -> String:
	return state_name

func enter() -> void:
	player.animation_tree["parameters/conditions/is_idle"] = false
	player.animation_tree["parameters/conditions/is_moving"] = true
	player.animation_tree["parameters/conditions/is_attacking"] = false
	player.animation_tree["parameters/conditions/is_charging"] = false

func exit() -> void:
	player.movement_vector = Vector2.ZERO

func physics_update(delta : float) -> void:
	if player.movement_vector: player.look_vector = player.movement_vector
	if player.look_vector.x != 0.0:
		player.look_vector = Vector2(player.look_vector.x, 0.0)
	
	player.movement_vector = Vector2(Input.get_axis("MoveLeft", "MoveRight"), Input.get_axis("MoveUp", "MoveDown"))
	
	player.velocity = player.movement_vector.normalized() * player.movement_speed * delta
	
	if player.movement_vector == Vector2.ZERO:
		state_machine.transition_states("Idle")
	
	elif Input.is_action_just_pressed("Attack"):
		player.velocity = Vector2.ZERO
		state_machine.transition_states("Attack")
