class_name Player extends CharacterBody2D

@onready var state_machine = $StateMachine

var look_vector : Vector2
var movement_vector : Vector2
var movement_speed : float = 7680.0

func _ready() -> void:
	initialize_state_machine()

# Inicializa la máquina de estados, agregando todos los estados posibles.
func initialize_state_machine() -> void:
	# El array "states" es donde van a ir todos los estados del jugador
	# Todos los estados del jugador tiene una clase especifica
	var states : Array[State] = [
		PlayerStateIdle.new(self), PlayerStateRunning.new(self), PlayerStateAttack.new(self),
		PlayerStateCharging.new(self), PlayerStateDashing.new(self)
		]
	state_machine.start_machine(states)

func _physics_process(delta) -> void:
	move_and_slide()

func _process(delta) -> void:
	queue_redraw()

func _draw() -> void:
	draw_line(Vector2.ZERO, look_vector * 32, Color.RED, 5.0, true)
