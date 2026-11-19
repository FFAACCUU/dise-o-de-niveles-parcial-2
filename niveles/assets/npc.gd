extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D

func _ready():
	SignalBus.connect("npc_notice", npc_notify)

func npc_notify():
	var tween := create_tween()
	
	animation_player.play("IdleLeft")
	tween.tween_property(sprite, "position", Vector2(0.0, -16.0), 0.1)
	tween.tween_property(sprite, "position", Vector2(0.0, 0.0), 0.1)
	tween.tween_interval(0.6)
	animation_player.play("MoveUp")
	tween.tween_property(self, "global_position", global_position + Vector2(0.0, -64.0), 0.5)
	animation_player.play("MoveLeft")
	tween.tween_property(self, "global_position", global_position + Vector2(-128.0, -64.0), 1.0)
	animation_player.play("IdleLeft")
	
