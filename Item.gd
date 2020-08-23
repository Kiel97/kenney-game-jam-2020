extends Area2D

export var value_increase = 0.1

func _on_Item_body_entered(body: Node) -> void:
	if body.name == "PlayerCorr":
		apply_item_to_player(body)

func apply_item_to_player(player: Node) -> void:
	self.queue_free()
