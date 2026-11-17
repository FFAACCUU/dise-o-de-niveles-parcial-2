class_name PlayerStateKnockback extends PlayerState

static var state_name := "Knockback"

var hop_tween : Tween
var knock_force : float = 64.0

func get_state_name() -> String:
	return state_name

func enter() -> void:
	if hop_tween:
		hop_tween.kill()
	hop_tween = player.create_tween()
	
	hop_tween.tween_property(player.sprite, "position", Vector2(0.0, -32.0), 0.1)
	hop_tween.tween_property(player.sprite, "position", Vector2(0.0, 0.0), 0.1)
	await hop_tween.finished
	state_machine.transition_states("Idle")

func exit() -> void:
	player.velocity = Vector2.ZERO

func physics_update(delta : float) -> void:
	player.velocity = -player.look_vector * (player.movement_speed * 0.5) * delta
