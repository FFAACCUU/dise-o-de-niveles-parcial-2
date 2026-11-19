extends Area2D

@export var move_direction : Vector2

@export var room : Room

var left : float
var top : float
var right : float
var bottom : float

func _ready() -> void:
	SignalBus.connect("room_transition", on_room_transition)
	
	left = room.global_position.x
	top = room.global_position.y
	right = room.bottom_right.global_position.x
	bottom = room.bottom_right.global_position.y

func _on_body_entered(_body):
	SignalBus.emit_signal("room_transition", true, move_direction)
	SignalBus.emit_signal("moved_room", left, top, right, bottom, move_direction)

func on_room_transition(is_transitioning : bool, dir : Vector2) -> void:
	if is_transitioning:
		set_deferred("monitoring", false)
	else:
		set_deferred("monitoring", true)
