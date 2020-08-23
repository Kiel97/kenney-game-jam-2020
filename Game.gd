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

	player.stop_player()
	
	yield($Win_SFX, "finished")
	Global.finish_game()

func _on_PlayerCorr_changed_jump_boost(value) -> void:
	jump_boost_bar.value = value

func _on_PlayerCorr_changed_move_boost(value) -> void:
	move_boost_bar.value = value

func _on_PlayerCorr_died() -> void:
	$BackgroudMusic.stop()
	$Lose_SFX.play()

	player.stop_player()
	
	yield($Lose_SFX, "finished")
	var extra_timer = get_tree().create_timer(0.5)
	yield(extra_timer, "timeout")
	
	Global.game_over()
