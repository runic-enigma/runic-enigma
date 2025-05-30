class_name DeckViewWindow extends ScrollContainer

@onready var card_container_scn: PackedScene = preload("res://scenes/ui/card_container.tscn")

@onready var flow_container = $HFlowContainer

var cached_card_containers: Array[CardContainer] = []

func clear_display():
	for child in flow_container.get_children():
		if child.usuable_card:
			child.remove_child(child.usuable_card)
		flow_container.remove_child(child)
	
func display_card_list(cardsWithId: Array[CardWithId]):
	clear_display()
	while cached_card_containers.size() < cardsWithId.size():
		cached_card_containers.push_back(card_container_scn.instantiate() as CardContainer)
	
	for i in cardsWithId.size():
		var cardWithId: CardWithId = cardsWithId[i] as CardWithId
		var card_container: CardContainer = cached_card_containers[i]
		flow_container.add_child(card_container)
		card_container.card = cardWithId.card
