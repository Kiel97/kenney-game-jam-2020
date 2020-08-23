extends "res://Item.gd"

func apply_item_to_player(player: Node) -> void:
	player.increase_jump_force(value_increase)
	.apply_item_to_player(player)
