extends Node

func _ready() -> void:
	show_main_menu()

func show_main_menu() -> void:
	get_tree().change_scene("res://MainMenu.tscn")

func start_game() -> void:
	get_tree().change_scene("res://Game.tscn")

func finish_game() -> void:
	get_tree().change_scene("res://WinScene.tscn")

func game_over() -> void:
	get_tree().change_scene("res://GameOverScene.tscn")
