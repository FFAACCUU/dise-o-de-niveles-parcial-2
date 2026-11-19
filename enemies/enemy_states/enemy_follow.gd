class_name EnemyStateFollow extends EnemyState

static var state_name := "Follow"

func get_state_name() -> String:
	return state_name

func physics_update(delta : float) -> void:
	if enemy.target:
		enemy.navigation_agent.target_position = enemy.target.global_position
		if enemy.navigation_agent.is_target_reached():
			enemy.velocity = Vector2.ZERO
		else:
			enemy.animation_player.play("Run")
			var dir := enemy.to_local(enemy.navigation_agent.get_next_path_position())
			enemy.velocity = dir.normalized() * enemy.move_speed * delta
			enemy.look_vector = dir.normalized()
		
		if enemy.global_position.distance_to(enemy.target.global_position) < 64.0:
			state_machine.transition_states("Attack")
		
	else:
		state_machine.transition_states("Idle")
