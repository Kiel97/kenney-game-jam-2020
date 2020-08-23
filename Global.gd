extends Node


func _ready() -> void:
	show_main_menu()

func show_main_menu() -> void:
	print("Show Menu")
	get_tree().change_scene("res://MainMenu.tscn")

func start_game() -> void:
	print("Now play time")
	get_tree().change_scene("res://Game.tscn")
