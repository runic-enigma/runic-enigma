extends Node2D

signal card_activated(card: UsuableCard)

@export var deck: Deck
@export var debug_mode: bool = true:
	set(value):
		if !is_node_ready():
			await ready
		debug_mode = value
		$Button.visible = debug_mode
		$Button2.visible = debug_mode
		$Button3.visible = debug_mode

@onready var fire_ball: CardData = preload("res://card_data/fire_ball.tres")

@onready var hand: Hand = $Hand

func reset():
	$Hand.empty_hand()
	
func add_card(card_with_id: CardWithId):
	$Hand.add_card(card_with_id.card)

func remove_card(card: Node2D):
	$Hand.remove_card_by_entity(card)

func _on_button_pressed() -> void:
	deck.add_card(fire_ball.duplicate())


func _on_button_2_pressed() -> void:
	#var defend_card = defend_card_scene.instantiate()
	pass
	#deck.add_card(defend_card)


func _on_hand_card_activated(card: UsuableCard) -> void:
	card.card.highlight()
	card_activated.emit(card)


func _on_button_3_pressed() -> void:
	if deck.get_cards().is_empty():
		return
		
	var random_card: CardWithId = deck.get_cards().pick_random()
	deck.remove_card(random_card.id)
