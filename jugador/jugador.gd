class_name Player extends CharacterBody2D

@onready var state_machine = $StateMachine

var max_health : int = 10
var current_health : int

var look_vector : Vector2 = Vector2(0.0, 1.0)
var movement_vector : Vector2
var movement_speed : float = 7680.0

@onready var sprite = $Sprite2D

var transition_direction : Vector2

@onready var sword_hurt_box = $HurtBoxSword
@onready var sword_collision = $HurtBoxSword/CollisionShape2D
@onready var hitbox_collision = $HitBox/CollisionShape2D
@onready var dash_collision = $HurtboxDash/CollisionShape2D

@onready var animation_tree = $AnimationTree

func _init() -> void:
	current_health = max_health

func _ready() -> void:
	SignalBus.connect("cutscene_transition", on_cut)
	initialize_state_machine()

func on_cut(time : float) -> void:
	var cut_tween := create_tween()
	cut_tween.tween_interval(time * 0.5)
	await cut_tween.finished
	global_position = Vector2(-1504.0, 352.0)

# Inicializa la máquina de estados, agregando todos los estados posibles.
func initialize_state_machine() -> void:
	# El array "states" es donde van a ir todos los estados del jugador
	# Todos los estados del jugador tiene una clase especifica
	var states : Array[State] = [
		PlayerStateIdle.new(self), PlayerStateRunning.new(self), PlayerStateAttack.new(self),
		PlayerStateCharging.new(self), PlayerStateDashing.new(self), PlayerStateKnockback.new(self),
		PlayerStateRoomtrans.new(self)
		]
	state_machine.start_machine(states)

func _physics_process(delta) -> void:
	move_and_slide()
	
	animation_tree["parameters/Idle/blend_position"] = look_vector
	animation_tree["parameters/Move/blend_position"] = look_vector
	animation_tree["parameters/Attack/blend_position"] = look_vector
	animation_tree["parameters/Charge/blend_position"] = look_vector


func _on_hit_box_area_entered(area):
	if area.is_in_group("Enemy"):
		current_health -= area.damage
		print(current_health)
