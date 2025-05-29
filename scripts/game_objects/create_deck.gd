class_name Deck extends Resource

var card_collection: Dictionary[int, CardWithId] = {}

var id_counter: int = 0

func add_card(card: CardData):
	var card_id = _generate_card_id(card)
	card_collection[card_id] = CardWithId.new(card_id, card)
	id_counter += 1
	
func remove_card(card_id: int):
	card_collection.erase(card_id)
	
func update_card(card_id: int, card: CardData):
	card_collection[card_id].card = card
	
func get_cards() -> Array[CardWithId]:
	var cards: Array[CardWithId] = []
	if !card_collection.is_empty():
		for card in card_collection.values():
			var duplicated_card_with_id: CardWithId = CardWithId.new(card.id, card.card.duplicate())
			cards.push_back(duplicated_card_with_id)
	
	return cards
	
	
func get_playable_deck() -> PlayableDeck:
	var playable_deck = PlayableDeck.new()
	playable_deck.cards = get_cards()
	return playable_deck

func _generate_card_id(card: CardData):
	return id_counter
	
