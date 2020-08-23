extends "res://Player.gd"

func flip_character(is_left: bool) -> void:
	.flip_character(is_left)
	$GnomeLeft.visible = not is_left
	$GnomeRight.visible = is_left

func stop_animation() -> void:
	$anim.stop()
