extends StaticBody2D

var initial_position : Vector2

@export var open_direction : Vector2 = Vector2(0.0, -1.0)
@export var open_ammount : float = 64.0
@export var open_time : float = 1.0
@export var close_time : float = 1.0

@export var stay_open : bool = true
var is_open : bool = false

var tween : Tween

@export var activator : Area2D

func _ready() -> void:
	initial_position = position
	if activator:
		activator.connect("area_entered", open)

func open(_area : Area2D) -> void:
	if is_open:
		return
	
	if tween:
		tween.kill()
	tween = create_tween()
	
	is_open = true
	
	tween.tween_property(self, "position", position + open_direction * open_ammount, open_time)
	await tween.finished
	if !stay_open:
		close()

func close() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	
	tween.tween_property(self, "position", initial_position, close_time)
	await tween.finished
	is_open = false
