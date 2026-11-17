class_name PlayerStateAttack extends PlayerState

static var state_name := "Attack"

func get_state_name() -> String:
	return state_name

#var combo_counter : int = 0

#var combo_timer : Tween
var attack_timer : Tween

func enter() -> void:
	player.animation_tree["parameters/conditions/is_idle"] = false
	player.animation_tree["parameters/conditions/is_moving"] = false
	player.animation_tree["parameters/conditions/is_attacking"] = true
	player.animation_tree["parameters/conditions/is_charging"] = false
	
	#if combo_timer:
	#	combo_timer.kill()
	#combo_timer = player.create_tween()
	if attack_timer:
		attack_timer.kill()
	attack_timer = player.create_tween()
	
	#match combo_counter:
	#	0:
	#		attack_anim_jab()
	#	1:
	#		attack_anim_swing()
	#	2:
	#		attack_anim_spin()
	
	player.sword_hurt_box.position = player.look_vector * 32
	
	player.sword_collision.disabled = false
	
	attack_timer.tween_interval(0.4)
	
	await attack_timer.finished
	player.sword_collision.disabled = true
	
	if Input.is_action_pressed("Attack"):
		state_machine.transition_states("Charging")
	
	else:
		state_machine.transition_states("Idle")
	
	#await combo_timer.finished
	#combo_counter = 0

func exit() -> void:
	if attack_timer:
		attack_timer.kill()

#func attack_anim_jab() -> void:
#	print("combo 1")
#	combo_counter += 1
#	attack_timer.tween_interval(0.2)
#	combo_timer.tween_interval(0.8)

#func attack_anim_swing() -> void:
#	print("combo 2")
#	combo_counter += 1
#	attack_timer.tween_interval(0.2)
#	combo_timer.tween_interval(0.8)

#func attack_anim_spin() -> void:
#	print("combo 3")
#	combo_counter = 0
#	attack_timer.tween_interval(0.4)
#	combo_timer.kill()
