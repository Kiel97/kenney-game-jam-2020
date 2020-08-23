extends Node

onready var player = $GameScene/PlayerCorr
onready var move_boost_bar = $GameGUI/Control/Container/MoveBoostBar
onready var jump_boost_bar = $GameGUI/Control/Container/JumpBoostBar

func _ready() -> void:
	$BackgroudMusic.play()

func _on_Door_body_entered(body: Node) -> void:
	if body.name == "PlayerCorr":
		end_game()
	
func end_game() -> void:
	$BackgroudMusic.stop()
	$Win_SFX.play()

	player.set_process(false)
	player.set_physics_process(false)
	player.set_process_input(false)
	player.stop_animation()
	
	yield($Win_SFX, "finished")
	Global.finish_game()

func _on_PlayerCorr_changed_jump_boost(value) -> void:
	jump_boost_bar.value = value

func _on_PlayerCorr_changed_move_boost(value) -> void:
	move_boost_bar.value = value
