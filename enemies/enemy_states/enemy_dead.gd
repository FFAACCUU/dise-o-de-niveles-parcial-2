class_name EnemyStateDead extends EnemyState

static var state_name := "Dead"

func get_state_name() -> String:
	return state_name

func enter() -> void:
	if enemy.has_key != 0:
		instantiate_key()
	enemy.velocity = Vector2.ZERO
	enemy.animation_player.play("Dead")

func instantiate_key():
	var new_key = enemy.key_thing.instantiate()
	new_key.position = enemy.position
	new_key.key_type = enemy.has_key
	enemy.get_tree().root.add_child(new_key)
	enemy.has_key = 0
