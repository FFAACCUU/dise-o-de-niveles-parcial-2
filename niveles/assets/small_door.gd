extends InteractArea

func on_interact() -> void:
	get_parent().call_deferred("queue_free")
