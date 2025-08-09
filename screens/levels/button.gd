extends Button


func _on_pressed() -> void:
	var battle_events: BattleEvents = get_tree().get_first_node_in_group("battle_events")

	battle_events.end_turn.emit()

