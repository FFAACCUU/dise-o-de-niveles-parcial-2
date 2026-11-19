class_name BossStateJump extends EnemyState

static var state_name := "Jump"

func get_state_name() -> String:
	return state_name

var tween : Tween

func enter() -> void:
	var jump_to_point = enemy.jumping_points.pick_random()
	
	if tween:
		tween.kill()
	tween = enemy.create_tween()
	
	tween.tween_property(enemy, "global_position", jump_to_point.global_position, 1.0)
	await tween.finished
	state_machine.transition_states("Idle")

func exit() -> void:
	if tween:
		tween.kill()
