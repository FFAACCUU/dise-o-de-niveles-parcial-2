class_name EnemyStateIdle extends EnemyState

static var state_name := "Idle"

func get_state_name() -> String:
	return state_name

func enter() -> void:
	enemy.animation_player.play("Idle")
	enemy.velocity = Vector2.ZERO

func update(delta : float) -> void:
	if enemy.target:
		state_machine.transition_states("Follow")
