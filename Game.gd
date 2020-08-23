extends Node


func _on_Door_body_entered(body: Node) -> void:
	if body.name == "PlayerCorr":
		Global.finish_game()
