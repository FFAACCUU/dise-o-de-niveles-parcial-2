extends HurtBox

func _on_body_entered(body):
	call_deferred("queue_free")
