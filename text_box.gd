extends Panel

@onready var label = $RichTextLabel

func _ready() -> void:
	SignalBus.connect("open_dialogue", update_text)
	SignalBus.connect("close_dialogue", wipe_text)

func update_text(new_text : String) -> void:
	label.text = new_text
	visible = true

func wipe_text() -> void:
	visible = false
	label.text = ""
