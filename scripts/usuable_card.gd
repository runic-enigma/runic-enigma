class_name UsuableCard extends Node2D

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)

var actions: Array[RefCounted]

@onready var card: Card = $Card
@onready var card_image: Sprite2D = $CardImage

func load_card_data(card_data: CardData):
	card.set_values(card_data.cost, card_data.name, card_data.description, card_data.type)
	card_image.set_texture(card_data.texture)
	for script in card_data.actions:
		var action_script = RefCounted.new()
		action_script.set_script(script)
		actions.push_back(action_script)

func highlight():
	$Card.highlight()
	self.z_index = 1
	
func unhighlight():
	$Card.unhighlight()
	self.z_index = 0

func get_cost() -> int:
	return $Card.card_cost
	
func get_type() -> PlayerData.Type:
	return $Card.type

func _on_card_mouse_entered(card: Card) -> void:
	mouse_entered.emit(self)

func _on_card_mouse_exited(card: Card) -> void:
	mouse_exited.emit(self)

func activate(game_state: Dictionary) -> void:
	for action in actions:
		action.activate(game_state)
