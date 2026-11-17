extends Area2D

@export var enable_transition : bool = false

func _on_area_entered(area):
	if area.is_in_group("PlayerDash"):
		SignalBus.emit_signal("toggle_player_transitions", enable_transition)
