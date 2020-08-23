extends Node


func start_game():
	Global.start_game()

func _on_BlinkTimer_timeout() -> void:
	_toggle_pick_to_start_visibility()

func _toggle_pick_to_start_visibility() -> void:
	$CanvasLayer/MenuGUI/PickToStart.visible = not $CanvasLayer/MenuGUI/PickToStart.visible

func _on_Gnome_body_entered(body: Node) -> void:
	if body.name == "Player":
		start_game()
