class_name PlayableDeckUI extends TextureButton

var deck: PlayableDeck

func draw() -> CardWithId:
	return deck.draw_card()
