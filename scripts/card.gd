class_name Card extends Node2D

@export var card_name: String = "Card name"
@export var card_description: String = "Card Description"
@export var card_cost: int = 1
# TODO: change card scene to template with different image
@export var card_image: Node2D

@onready var cost_label: Label = $CostDisplay/CostLabel
@onready var name_label: Label = $CardName/NameLabel
@onready var description_label: Label = $CardDescription

func _ready() -> void:
	cost_label.set_text(str(card_cost))
	name_label.set_text(card_name)
	description_label.set_text(card_description)
