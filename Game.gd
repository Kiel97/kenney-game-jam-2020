extends Node

onready var player = $GameScene/PlayerCorr
onready var move_boost_bar = $GameGUI/Control/VBoxContainer/MoveBoostBar
onready var jump_boost_bar = $GameGUI/Control/VBoxContainer/JumpBoostBar


func _on_Door_body_entered(body: Node) -> void:
	if body.name == "PlayerCorr":
		end_game()
	
func end_game() -> void:
	var win_timer = get_tree().create_timer(2.0)
	player.set_process(false)
	player.set_physics_process(false)
	player.set_process_input(false)
	player.stop_animation()
	
	yield(win_timer, "timeout")
	Global.finish_game()

func _on_PlayerCorr_changed_jump_boost(value) -> void:
	jump_boost_bar.value = value

func _on_PlayerCorr_changed_move_boost(value) -> void:
	move_boost_bar.value = value
