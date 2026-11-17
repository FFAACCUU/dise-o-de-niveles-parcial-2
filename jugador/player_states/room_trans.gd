class_name PlayerStateRoomtrans extends PlayerState

static var state_name := "Room Transition"

var transition_tween : Tween

func get_state_name() -> String:
	return state_name

func enter() -> void:
	if transition_tween:
		transition_tween.kill()
	transition_tween = player.create_tween()
	
	transition_tween.tween_property(player, "global_position", player.global_position + player.transition_direction * 128.0, 0.6)
