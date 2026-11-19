extends Area2D

@export var room : Room

func _on_body_entered(body):
	SignalBus.emit_signal("cutscene_transition", 8.0)
	SignalBus.emit_signal("send_current_room", room.name)
