class_name EnemyStateAttack extends EnemyState

static var state_name := "Attack"

var tween : Tween

func get_state_name() -> String:
	return state_name

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	
	if tween:
		tween.kill()
	tween = enemy.create_tween()
	
	enemy.animation_player.play("Attack")
	tween.tween_interval(0.6)
	await tween.finished
	tween.kill()
	tween = enemy.create_tween()
	enemy.hurt_box_sword.position.x = enemy.look_vector.x * 40.0
	enemy.sword_collision.set_deferred("disabled", false)
	tween.tween_interval(0.2)
	await tween.finished
	enemy.sword_collision.disabled = true
	state_machine.transition_states("Idle")

func exit() -> void:
	if tween:
		tween.kill()
	enemy.sword_collision.set_deferred("disabled", true)
