extends Node

signal room_transition(is_transitioning : bool, direction : Vector2)
signal moved_room(left : int, top : int, right : int, bottom : int, move_dir : Vector2)

signal toggle_player_transitions(toggle : bool)

signal cutscene_transition(time : float)
signal cutsece_end

signal open_dialogue(new_text : String)
signal close_dialogue

signal send_current_room(the_room : String)

signal start_boss
signal fr_start_boss_now
signal npc_notice
signal boss_end
