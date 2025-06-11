extends Node2D


@export var card_name: String = "Golden fire ball"
@export var card_description: String = "Deal 12 dmg"
@export var card_cost: int = 5
@export var card_background: Sprite2D
@export var type: PlayerData.Type
@export var clicked: bool = false

@onready var cost_label: Label = $CostDisplay/CostLabel
@onready var name_label: Label = $CardText/NameLabel
@onready var description_label: Label = $CardText/CardDescription
@onready var background_sprite: Sprite2D = $CardSchema
@onready var card_sprite: Sprite2D = $CardImage/CardImage

func _ready() -> void:
	set_values(card_cost, card_name, card_description, type)
	background_sprite.set_modulate(Color8(255, 255, 0, 255))
	
func set_values(_cost: int, _name: String, _description: String, _type: PlayerData.Type) -> void:
	card_name = _name
	card_description = _description
	card_cost = _cost
	type = _type
	_update_graphics()

func _update_graphics() -> void:
	if cost_label.get_text() != str(card_cost):
		cost_label.set_text(str(card_cost))
	if name_label.get_text() != card_name:
		name_label.set_text(card_name)
	if description_label.get_text() != card_description:
		description_label.set_text(card_description)
