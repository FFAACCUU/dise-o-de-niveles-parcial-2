extends Area2D

@export var left : int
@export var top : int
@export var right : int
@export var bottom : int
@export var move_direction : Vector2

func _ready() -> void:
	SignalBus.connect("room_transition", on_room_transition)

func _on_body_entered(_body):
	SignalBus.emit_signal("room_transition", true, move_direction)
	SignalBus.emit_signal("moved_room", left, top, right, bottom, move_direction)

func on_room_transition(is_transitioning : bool, dir : Vector2) -> void:
	if is_transitioning:
		set_deferred("monitoring", false)
	else:
		set_deferred("monitoring", true)
