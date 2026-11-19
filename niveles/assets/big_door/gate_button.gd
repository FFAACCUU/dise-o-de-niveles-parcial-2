extends Area2D

var tween : Tween

@onready var lever = $Lever

var can_pull : bool = true

func _on_area_entered(area):
	if can_pull:
		can_pull = false
		lever.frame = 2
		
		if tween:
			tween.kill()
		tween = create_tween()
		
		tween.tween_interval(1.2)
		await tween.finished
		lever.frame = 0
		can_pull = true
