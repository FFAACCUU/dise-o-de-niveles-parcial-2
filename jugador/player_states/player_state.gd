class_name PlayerState extends State

var player : Player
var state_machine : StateMachine

func _init(player_instance : Player) -> void:
	player = player_instance
	state_machine = player.state_machine
	
	# Extra inicializacion para los estados que la necesiten
	_state_init()
