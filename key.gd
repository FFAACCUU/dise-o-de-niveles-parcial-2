extends Area2D

@export var key_type : int = 2
@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.frame = key_type - 2

func _on_body_entered(body):
	if key_type == 2:
		body.llave_2 = true
	if key_type == 3:
		body.llave_3 = true
	
	call_deferred("queue_free")
