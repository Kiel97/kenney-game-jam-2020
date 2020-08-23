extends Node

onready var player = $GameScene/PlayerCorr

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
