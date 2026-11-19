class_name PlayerStateDead extends PlayerState

static var state_name := "Die"

func get_state_name() -> String:
	return state_name

func enter() -> void:
	player.velocity = Vector2.ZERO
	player.is_dead_dead = true
	player.animation_tree.active = false
	player.animation_player.play("Die")
