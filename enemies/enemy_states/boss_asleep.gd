class_name BossStateAsleep extends EnemyState

static var state_name := "Asleep"

func get_state_name() -> String:
	return state_name

func enter() -> void:
	enemy.animation_player.play("Idle")
	enemy.velocity = Vector2.ZERO

func update(delta : float) -> void:
	enemy.look_vector = enemy.to_local(enemy.player_node.global_position).normalized()
