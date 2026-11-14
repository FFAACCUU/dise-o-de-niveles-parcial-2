class_name PlayerStateDashing extends PlayerState

static var state_name := "Dashing"

func get_state_name() -> String:
	return state_name

func physics_update(delta : float) -> void:
	player.velocity = player.look_vector * (player.movement_speed * 4) * delta

func exit() -> void:
	player.velocity = Vector2.ZERO

func update(delta : float) -> void:
	if Input.is_action_just_pressed("Attack"):
		state_machine.transition_states("Idle")
