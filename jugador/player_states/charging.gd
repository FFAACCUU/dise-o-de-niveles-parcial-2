class_name PlayerStateCharging extends PlayerState

static var state_name := "Charging"

func get_state_name() -> String:
	return state_name

var charge_interval : float = 1.0
var charge : float = 0.0

func physics_update(delta : float) -> void:
	player.movement_vector = Vector2(Input.get_axis("MoveLeft", "MoveRight"), Input.get_axis("MoveUp", "MoveDown"))
	
	player.velocity = player.movement_vector.normalized() * (player.movement_speed * 0.5) * delta

func enter() -> void:
	player.animation_tree["parameters/conditions/is_idle"] = false
	player.animation_tree["parameters/conditions/is_moving"] = false
	player.animation_tree["parameters/conditions/is_attacking"] = false
	player.animation_tree["parameters/conditions/is_charging"] = true

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
