extends Area2D


func _on_body_entered(body):
	SignalBus.emit_signal("cutscene_transition", 8.0)
