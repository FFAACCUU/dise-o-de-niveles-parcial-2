class_name PlayerStateCharging extends PlayerState

static var state_name := "Charging"

func get_state_name() -> String:
	return state_name

var charge_interval : float = 1.0
var charge : float = 0.0

func physics_update(delta : float) -> void:
	player.movement_vector = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	
	player.velocity = player.movement_vector * (player.movement_speed * 0.5) * delta

func exit() -> void:
	charge = 0.0

func update(delta : float) -> void:
	charge += charge_interval * delta
	charge = clampf(charge, 0.0, 1.0)
	
	if Input.is_action_just_released("Attack"):
		if charge == 1.0:
			state_machine.transition_states("Dashing")
		else:
			state_machine.transition_states("Idle")
