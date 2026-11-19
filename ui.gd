extends CanvasLayer

@onready var cutscene_transition = $CutsceneTransition

@export var player_node : Player

func _ready() -> void:
	SignalBus.connect("cutscene_transition", on_cut)


func on_cut(time : float) -> void:
	var cut_tween := create_tween()
	
	cut_tween.tween_property(cutscene_transition, "color", Color(0.133, 0.11, 0.102, 1.0), time * 0.25)
	cut_tween.tween_interval(time * 0.25)
	cut_tween.tween_property(cutscene_transition, "color", Color(0.133, 0.11, 0.102, 0.0), time * 0.25)
