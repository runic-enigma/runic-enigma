@tool
class_name Card extends Node2D

@export var card_name: String = "Card name"
@export var card_description: String = "Card Description"
@export var card_cost: int = 1
# TODO: change card scene to template with different image
@export var card_image: Sprite2D

@onready var cost_label: Label = $CostDisplay/CostLabel
@onready var name_label: Label = $CardName/NameLabel
@onready var description_label: Label = $CardDescription

func _ready() -> void:
	set_values(card_cost, card_name, card_description)
	
func set_values(_cost: int, _name: String, _description: String) -> void:
	card_name = _name
	card_description = _description
	card_cost = _cost
	
	_update_graphics()
	
func _update_graphics() -> void:
	if cost_label.get_text() != str(card_cost):
		cost_label.set_text(str(card_cost))
	if name_label.get_text() != card_name:
		name_label.set_text(card_name)
	if description_label.get_text() != card_description:
		description_label.set_text(card_description)

func _process(delta: float) -> void:
	_update_graphics()
