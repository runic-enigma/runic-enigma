extends Node2D

@onready var attack_card_scene: PackedScene = preload("res://scenes/cards/attack_card.tscn")
@onready var defend_card_scene: PackedScene = preload("res://scenes/cards/defend_card.tscn")

@onready var hand: Hand = $CanvasLayer/Hand
@onready var spawn_point = $CanvasLayer/Spawn

func _on_button_pressed() -> void:
	var attack_card = attack_card_scene.instantiate()
	hand.add_card(attack_card)


func _on_button_2_pressed() -> void:
	var defend_card = defend_card_scene.instantiate()
	hand.add_card(defend_card)
