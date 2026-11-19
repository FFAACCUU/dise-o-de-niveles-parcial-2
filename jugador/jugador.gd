class_name Player extends CharacterBody2D

@onready var state_machine = $StateMachine

var max_health : int = 10
var current_health : int

@onready var animation_player = $AnimationPlayer

var look_vector : Vector2 = Vector2(0.0, -1.0)
var movement_vector : Vector2
var movement_speed : float = 11520.0

var is_dead_dead : bool = false

@onready var sprite = $Sprite2D

var transition_direction : Vector2

var interaction_areas := []
var can_interact : bool = true

var llave_1 : bool = false
var llave_2 : bool = false
var llave_3 : bool = false

@onready var sword_hurt_box = $HurtBoxSword
@onready var sword_collision = $HurtBoxSword/CollisionShape2D
@onready var hitbox_collision = $HitBox/CollisionShape2D
@onready var dash_collision = $HurtboxDash/CollisionShape2D

@onready var animation_tree = $AnimationTree

@onready var interactor = $Interactor

func _init() -> void:
	current_health = max_health

func _ready() -> void:
	SignalBus.connect("cutscene_transition", on_cut)
	SignalBus.connect("open_dialogue", when_interact_start)
	SignalBus.connect("close_dialogue", when_interact_end)
	initialize_state_machine()

func when_interact_start(lol : String) -> void:
	can_interact = false

func when_interact_end() -> void:
	can_interact = true

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
		PlayerStateRoomtrans.new(self), PlayerStateDead.new(self)
		]
	state_machine.start_machine(states)

func _physics_process(delta) -> void:
	move_and_slide()
	
	animation_tree["parameters/Idle/blend_position"] = look_vector
	animation_tree["parameters/Move/blend_position"] = look_vector
	animation_tree["parameters/Attack/blend_position"] = look_vector
	animation_tree["parameters/Charge/blend_position"] = look_vector

func _process(delta) -> void:
	if can_interact:
		if interactor.has_overlapping_areas():
			interaction_areas = interactor.get_overlapping_areas()
		else:
			interaction_areas.clear()
		
		if interaction_areas:
			if Input.is_action_just_pressed("Interact"):
				for i in interaction_areas:
					i.on_interact()
	else:
		interaction_areas.clear()
	
	
	queue_redraw()

func _draw():
	if interaction_areas:
		draw_line(Vector2(0.0, -80.0), Vector2(0.0, -104.0), Color(1.0, 1.0, 1.0, 1.0), 8.0)
		draw_line(Vector2(0.0, -84.0), Vector2(0.0, -102.0), Color(1.0, 0.0, 0.0, 1.0), 6.0)
		
		draw_circle(Vector2(0.0, -72.0), 6.0, Color(1.0, 1.0, 1.0, 1.0), true)
		draw_circle(Vector2(0.0, -72.0), 4.0, Color(1.0, 0.0, 0.0, 1.0), true)

func _on_hit_box_area_entered(area):
	if area.is_in_group("Enemy"):
		current_health -= area.damage
		if current_health >= max_health:
			current_health = max_health
		
		if current_health <= 0:
			state_machine.transition_states("Die")
		print(current_health)
