extends Node


func start_game():
	#TODO Replace with actual start method body
	get_tree().reload_current_scene()

func _on_BlinkTimer_timeout() -> void:
	_toggle_pick_to_start_visibility()

func _toggle_pick_to_start_visibility() -> void:
	$CanvasLayer/MenuGUI/PickToStart.visible = not $CanvasLayer/MenuGUI/PickToStart.visible

func _on_Gnome_body_entered(body: Node) -> void:
	if body.name == "Player":
		start_game()
