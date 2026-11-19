extends Area2D

func _on_body_entered(body):
	SignalBus.emit_signal("npc_notice")
	call_deferred("queue_free")
