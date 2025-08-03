class_name Level extends Node2D

# TODO: Add player and data types
@export var player: String
var data: String

func _ready() -> void:
	player = "non-visible"

	if data == null:
		enter_level()

func enter_level() -> void:
	if data != null:
		print("Level entered!")
