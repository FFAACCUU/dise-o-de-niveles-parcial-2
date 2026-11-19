extends CharacterBody2D

var max_health : int = 5
var current_health : int

var target : Node2D

@export var is_boss_ally : bool = false

var key_thing := preload("uid://qttrjxdq5q4u")

var initial_position : Vector2

@onready var sprite = $Sprite

@export var has_key : int = 0

@export var mf_that_gets_deleted : bool = false

@onready var state_machine = $StateMachine

@onready var detection_area = $DetectionArea

@export var active_room : Room

var move_speed : float = 7680.0

@onready var navigation_agent = $NavigationAgent2D

@onready var animation_player = $AnimationPlayer

@export var look_vector : Vector2 = Vector2(0.0, -1.0)

@onready var hurt_box_sword = $HurtBoxSword
@onready var sword_collision = $HurtBoxSword/CollisionShape2D

var is_dead_dead : bool = false

func _ready():
	SignalBus.connect("start_boss", delete_if_necesary)
	current_health = max_health
	initial_position = global_position
	initialize_state_machine()

func initialize_state_machine() -> void:
	# El array "states" es donde van a ir todos los estados del jugador
	# Todos los estados del jugador tiene una clase especifica
	var states : Array[State] = [
		EnemyStateIdle.new(self), EnemyStateAsleep.new(self), EnemyStateFollow.new(self),
		EnemyStateAttack.new(self), EnemyStateDead.new(self)
		]
	state_machine.start_machine(states)

func delete_if_necesary():
	if mf_that_gets_deleted:
		call_deferred("queue_free")
	
	if is_boss_ally:
		visible = true

func _physics_process(delta) -> void:
	move_and_slide()

func _on_detection_area_body_entered(body):
	target = body

func _on_detection_area_body_exited(body):
	target = null

func _process(delta):
	if look_vector.x <= 0.0:
		sprite.scale.x = -2
	else:
		sprite.scale.x = 2


func _on_hit_box_area_entered(area):
	if area.is_in_group("Player"):
		current_health -= area.damage
		if current_health <= 0:
			state_machine.override_transition_states("Dead")
		print(current_health)
