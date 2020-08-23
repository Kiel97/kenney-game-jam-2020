extends "res://Item.gd"

func apply_item_to_player(player: Node) -> void:
	player.increase_move_boost(value_increase)
	.apply_item_to_player(player)
