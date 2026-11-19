extends Node2D

func _ready():
	SignalBus.connect("fr_start_boss_now", on_boss_start)
	SignalBus.connect("boss_end", on_end)

func on_boss_start():
	visible = true

func on_end():
	visible = false
