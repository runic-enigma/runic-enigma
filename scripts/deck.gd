extends Node2D

signal card_activated(card: UsuableCard)

@onready var attack_card_scene: PackedScene = preload("res://scenes/cards/attack_card.tscn")
@onready var defend_card_scene: PackedScene = preload("res://scenes/cards/defend_card.tscn")

@onready var hand: Hand = $Hand

func _on_button_pressed() -> void:
	var attack_card = attack_card_scene.instantiate()
	hand.add_card(attack_card)


func _on_button_2_pressed() -> void:
	var defend_card = defend_card_scene.instantiate()
	hand.add_card(defend_card)


func _on_hand_card_activated(card: UsuableCard) -> void:
	card_activated.emit(card)
