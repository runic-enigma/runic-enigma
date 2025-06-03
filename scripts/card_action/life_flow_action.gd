extends RefCounted

func activate(game_state: Dictionary) -> void:

	game_state.get("caster").spend_mana(2)
	game_state.get("caster").add_health(2)
