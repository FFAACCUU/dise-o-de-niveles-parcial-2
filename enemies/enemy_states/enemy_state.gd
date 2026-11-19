class_name EnemyState extends State

var enemy : CharacterBody2D
var state_machine : StateMachine

func _init(player_instance : CharacterBody2D) -> void:
	enemy = player_instance
	state_machine = enemy.state_machine
	
	# Extra inicializacion para los estados que la necesiten
	_state_init()
