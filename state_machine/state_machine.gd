class_name StateMachine extends Node

var current_state : State
var states : Dictionary = {}

@export var player : Player
@onready var label = $"../Label"

var last_state : State

func _ready() -> void:
	SignalBus.connect("room_transition", transition_room)

func transition_room(is_active : bool, trans_dir : Vector2) -> void:
	if is_active:
		player.transition_direction = trans_dir
		last_state = current_state
		transition_states("Room Transition")
	else:
		transition_states(last_state.get_state_name())

func start_machine(init_states : Array[State]) -> void:
	for state in init_states:
		states[state.get_state_name()] = state
	
	current_state = init_states[0]
	current_state.enter()

func _process(delta : float) -> void:
	current_state.update(delta)
	
	label.text = current_state.get_state_name()

func _physics_process(delta : float) -> void:
	current_state.physics_update(delta)

func transition_states(new_state_name : String) -> void:
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
