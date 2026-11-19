extends CanvasLayer

@onready var cutscene_transition = $CutsceneTransition

@export var player_node : Player

@onready var bar = $ProgressBar

@onready var key_1 = $Key1
@onready var key_2 = $Key2
@onready var key_3 = $Key3

func _ready() -> void:
	bar.max_value = player_node.max_health
	SignalBus.connect("cutscene_transition", on_cut)

func on_cut(time : float) -> void:
	var cut_tween := create_tween()
	
	cut_tween.tween_property(cutscene_transition, "color", Color(0.133, 0.11, 0.102, 1.0), time * 0.25)
	cut_tween.tween_interval(time * 0.25)
	cut_tween.tween_property(cutscene_transition, "color", Color(0.133, 0.11, 0.102, 0.0), time * 0.25)

func _process(delta):
	bar.value = player_node.current_health
	
	if player_node.llave_1:
		key_1.visible = true
	if player_node.llave_2:
		key_2.visible = true
	if player_node.llave_3:
		key_3.visible = true
