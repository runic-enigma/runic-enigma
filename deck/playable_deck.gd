class_name PlayableDeck extends Node2D

var cards: Array[CardData] = []

func setup(initial_cards: Array[CardData]) -> void:
	self.cards = initial_cards
	shuffle()

func shuffle() -> void:
	cards.shuffle()


func draw_card() -> CardData:
	if not cards.is_empty():
		return cards.pop_front()
	return null

func draw_cards(amount: int) -> Array[CardData]:
	var drawn_cards: Array[CardData] = []
	for i in range(amount):
		var card: CardData = draw_card()
		if card:
			drawn_cards.append(card)
		else:
			break
	return drawn_cards

func add_to_bottom(card: CardData) -> void:
	cards.push_back(card)

func get_card_count() -> int:
	return cards.size()
