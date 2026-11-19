class_name BossStateIdle extends EnemyState

static var state_name := "Idle"

var tween : Tween

func get_state_name() -> String:
	return state_name

func enter() -> void:
	if tween:
		tween.kill()
	
	tween = enemy.create_tween()
	
	tween.tween_interval(randf_range(1.0, 3.0))

func update(delta : float) -> void:
	enemy.look_vector = enemy.to_local(enemy.player_node.global_position).normalized()
