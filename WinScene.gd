extends Control

func _ready() -> void:
	$BackgroundMusic.play()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		Global.show_main_menu()
