class_name Deck extends RefCounted

var card_collection: Dictionary = {}

var id_counter: int = 0

func add_card(card: UsuableCard):
	var card_id = _generate_card_id(card)
	card.collection[card_id] = card
	id_counter += 1
	
func remove_card(card_id: String):
	card_collection.erase(card_id)
	
func update_card(card_id: String, card: UsuableCard):
	card_collection[card_id] = card
	
func get_cards() -> Array[UsuableCard]:
	return []
	
func _generate_card_id(card: UsuableCard):
	return id_counter
	
