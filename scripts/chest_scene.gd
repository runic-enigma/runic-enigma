extends Node2D

func _ready() -> void:
	$"../Music".play()

func _on_add_card_pressed() -> void:
	$"../ClickSound".play()
	$CanvasLayer/CardOverlay.hide()
