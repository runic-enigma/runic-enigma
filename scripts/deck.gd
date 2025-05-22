extends Node2D

@onready var card_scene: PackedScene = preload("res://scenes/card.tscn")

@onready var spawn_point = $CanvasLayer/Spawn

func _on_button_pressed() -> void:
	var card: Card = card_scene.instantiate()
	spawn_point.add_child(card)
	card.set_values(3, "Test card", "Test description.")
	card.show()


func _on_button_2_pressed() -> void:
	var card: Card = card_scene.instantiate()
	spawn_point.add_child(card)
	card.set_values(5, "Test card 2", "Test description 2.")
	card.show()
