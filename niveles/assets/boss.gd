extends CharacterBody2D

@export var jumping_points : Array[Marker2D]

var max_health : int = 5
var current_health : int

var look_vector : Vector2 = Vector2.ZERO

@onready var state_machine = $StateMachine

var is_dead_dead : bool = false
@export var player_node : Player

@export var is_boss_ally : bool = false

var key_thing := preload("uid://qttrjxdq5q4u")

var initial_position : Vector2

@onready var sprite = $Sprite

@export var has_key : int = 0

@export var mf_that_gets_deleted : bool = false

@export var active_room : Room

var move_speed : float = 7680.0

@onready var animation_player = $AnimationPlayer

func _ready():
	SignalBus.connect("start_boss", on_start_boss)
	current_health = max_health
	initialize_state_machine()

func on_start_boss():
	var tween := create_tween()
	tween.tween_property(self, "global_position", global_position + Vector2(0.0, 1472.0), 0.8)

func initialize_state_machine() -> void:
	# El array "states" es donde van a ir todos los estados del jugador
	# Todos los estados del jugador tiene una clase especifica
	var states : Array[State] = [
		BossStateIdle.new(self), BossStateJump.new(self), BossStateAsleep.new(self)
		]
	state_machine.start_machine(states)

func _on_hit_box_area_entered(area):
	if area.is_in_group("Player"):
		current_health -= area.damage
		if current_health <= 0:
			state_machine.override_transition_states("Dead")
		print(current_health)
