@tool
class_name Card extends Node2D

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)

@export var card_name: String = "Card name"
@export var card_description: String = "Card Description"
@export var card_cost: int = 1
@export var card_background: Sprite2D
@export var type: PlayerData.Type

@onready var cost_label: Label = $CostDisplay/CostLabel
@onready var name_label: Label = $CardText/NameLabel
@onready var description_label: Label = $CardText/CardDescription
@onready var background_sprite: Sprite2D = $CardSchema
@onready var card_sprite: Sprite2D = $CardImage/CardImage

func _ready() -> void:
	set_values(card_cost, card_name, card_description, type)
	
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

func highlight():
	background_sprite.set_modulate(Color(0.13,0.7,1, 1))

func unhighlight():
	background_sprite.set_modulate(Color(1,1,1,1))

func activate():
	pass

func _process(delta: float) -> void:
	_update_graphics()
	
func _on_area_2d_mouse_entered() -> void:
	mouse_entered.emit(self)
	
func _on_area_2d_mouse_exited() -> void:
	mouse_exited.emit(self)
