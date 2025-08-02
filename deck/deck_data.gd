class_name DeckData extends Resource

signal deck_changed

@export var entries: Array[DeckEntry] = []

func add_card(card_data: CardData, amount: int = 1) -> void:
	for entry in entries:
		if entry.card == card_data:
			entry.quantity += amount
			deck_changed.emit()
			return

		var new_entry: DeckEntry= DeckEntry.new()
		new_entry.card = card_data
		new_entry.quantity = amount
		entries.append(new_entry)
		deck_changed.emit()

func remove_card(card_data: CardData, amount: int = 1) -> void:
	for i in range(entries.size() -1, -1, -1):
		var entry: DeckEntry = entries[i]
		if entry.card == card_data:
			entry.quantity -= amount
			if entry.quantity <= 0:
				entries.remove_at(i)
			deck_changed.emit()
			return

func get_total_card_count() -> int:
	var total: int = 0
	for entry in entries:
		total += entry.quantity

	return total

func get_card_quantity(card_data: CardData) -> int:
	for entry in entries:
		if entry.card == card_data:
			return entry.quantity
	return 0

func clear() -> void:
	entries.clear()
	deck_changed.emit()

func create_card_list() -> Array[CardData]:
	var card_list: Array[CardData] = []
	for entry in entries:
		for i in range(entry.quantity):
			card_list.append(entry.card)
	return card_list
