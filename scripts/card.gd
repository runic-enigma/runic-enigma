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
	set_values(card_cost, card_name, card_description)
	hide()
	
func set_values(_cost: int, _name: String, _description: String) -> void:
	card_name = _name
	card_description = _description
	card_cost = _cost
	
	cost_label.set_text(str(_cost))
	name_label.set_text(_name)
	description_label.set_text(_description)
	
