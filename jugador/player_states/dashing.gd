class_name PlayerStateDashing extends PlayerState

static var state_name := "Dashing"

func get_state_name() -> String:
	return state_name

func physics_update(delta : float) -> void:
	player.velocity = player.look_vector.normalized() * (player.movement_speed * 4) * delta
	
	for i in player.get_slide_collision_count():
		var collision := player.get_slide_collision(0)
		
		var direction_to_collision_pos := player.position.direction_to(collision.get_position()).round()
		
		if direction_to_collision_pos == player.look_vector:
			state_machine.transition_states("Knockback")
		elif player.get_slide_collision_count() == 2:
			state_machine.transition_states("Knockback")
		

func enter() -> void:
	player.animation_tree["parameters/conditions/is_idle"] = false
	player.animation_tree["parameters/conditions/is_moving"] = false
	player.animation_tree["parameters/conditions/is_attacking"] = false
	player.animation_tree["parameters/conditions/is_charging"] = true
	
	player.dash_collision.set_deferred("disabled", false)
	player.hitbox_collision.set_deferred("disabled", true)

func exit() -> void:
	player.dash_collision.set_deferred("disabled", true)
	player.hitbox_collision.set_deferred("disabled", false)
	player.velocity = Vector2.ZERO

func update(delta : float) -> void:
	if Input.is_action_just_pressed("Attack"):
		state_machine.transition_states("Idle")
