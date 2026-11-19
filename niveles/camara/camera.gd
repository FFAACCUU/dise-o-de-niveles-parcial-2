extends Camera2D

var transition_tween : Tween

func _ready() -> void:
	SignalBus.connect("cutscene_transition", on_cut)
	SignalBus.connect("moved_room", room_transition)

func room_transition(n_left : int, n_top : int, n_right : int, n_bottom : int, direction : Vector2) -> void:
	if transition_tween:
		transition_tween.kill()
	transition_tween = create_tween()
	
	transition_tween.tween_property(self, "offset", (Vector2(832.0 * direction.x, 704.0 * direction.y)), 0.8)
	await transition_tween.finished
	offset = Vector2.ZERO
	SignalBus.emit_signal("room_transition", false, Vector2.ZERO)
	
	limit_left = n_left
	limit_top = n_top
	limit_right = n_right
	limit_bottom = n_bottom

func on_cut(time : float) -> void:
	var cut_tween := create_tween()
	cut_tween.tween_interval(time * 0.5)
	await cut_tween.finished
	limit_left = -2944
	limit_top = 0
	limit_right = -896
	limit_bottom = 704
