class_name PlayableDeck extends Resource

var cards: Array[CardWithId] = []

func draw_card() -> CardWithId:
	return cards.pop_back()

func shuffle():
	cards.shuffle()

func peek_top() -> CardWithId:
	return cards.back()
	
func put_card_on_top(card: CardWithId):
	cards.push_back(card)
