class_name EnemyStateAsleep extends EnemyState

static var state_name := "Asleep"

func get_state_name() -> String:
	return state_name

func enter() -> void:
	enemy.current_health = enemy.max_health
	enemy.animation_player.play("Idle")
	enemy.global_position = enemy.initial_position
	enemy.velocity = Vector2.ZERO
	enemy.detection_area.set_deferred("monitoring", false)

func exit() -> void:
	enemy.detection_area.set_deferred("monitoring", true)
