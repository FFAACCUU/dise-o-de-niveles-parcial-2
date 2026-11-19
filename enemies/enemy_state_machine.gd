extends StateMachine

var is_room_active : bool = false

func _ready() -> void:
	SignalBus.connect("send_current_room", check_room)
	
	SignalBus.connect("toggle_player_transitions", toggle_player_transition)
	SignalBus.connect("room_transition", transition_room)
	
	SignalBus.connect("open_dialogue", when_interact_start)
	SignalBus.connect("close_dialogue", when_interact_end)

func transition_room(is_active : bool, trans_dir : Vector2) -> void:
	if is_active:
		override_transition_states("Asleep")
	else:
		if is_room_active:
			override_transition_states("Idle")
		else:
			override_transition_states("Asleep")

func check_room(room : String):
	if room == player.active_room.name:
		is_room_active = true
	else:
		is_room_active = false

func override_transition_states(new_state_name : String) -> void:
	if !player.is_dead_dead:
		var new_state : State = states.get(new_state_name)
		var current_state_name : String = current_state.get_state_name()
	
		if new_state == null:
			push_error("No puede hacerse la transicion de estado. (%s) no existe." % new_state_name)
		elif new_state != current_state:
			current_state.exit()
			current_state = states[new_state.get_state_name()]
			current_state.enter()
		else:
			push_warning("No se puede transicionar desde el mismo estado.")
