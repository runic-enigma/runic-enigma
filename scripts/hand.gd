@tool
class_name Hand extends Node2D

signal card_activated(card: UsuableCard)

@export var hand_radius: int = 100
@export var card_angle: float = PI / 2
@export var angle_limit: float = PI / 6
@export var max_card_spread_angle: float = PI / 16

@onready var collision_shape: CollisionShape2D = $DebugShape
@onready var usuable_card_scn: PackedScene = preload("res://scenes/cards/usuable_card.tscn")

var hand: Array[UsuableCard] = []
var touched: Array[UsuableCard] = []
var current_selected_card_index: int = -1

func empty_hand():
	current_selected_card_index = -1
	for card in hand:
		card.queue_free()
	hand = []
	touched = []
	
func add_card(card_data: CardData) -> void: 
	var usuable_card = usuable_card_scn.instantiate()
	hand.push_back(usuable_card)
	add_child(usuable_card)
	usuable_card.load_card_data(card_data)
	
	usuable_card.mouse_entered.connect(_handle_card_touched)
	usuable_card.mouse_exited.connect(_handle_card_untouched)
	reposition_cards()
	
func remove_card(index: int) -> Node2D:
	var removing_card = hand[index]
	hand.remove_at(index)
	touched.remove_at(touched.find(removing_card))
	remove_child(removing_card)
	reposition_cards()
	return removing_card
	
func remove_card_by_entity(card: UsuableCard):
	var remove_index = hand.find(card)
	remove_card(remove_index)
	
func reposition_cards():
	var card_spread = min(angle_limit, max_card_spread_angle) / hand.size()
	var current_angle = -(card_spread * (hand.size() - 1))/2 - PI / 2
	for card in hand:
		_update_card_transform(card, current_angle)
		current_angle += card_spread

# IMPORTANT: angle is in radians
func get_card_position(angle: float) -> Vector2:
	var x: float = hand_radius * cos(angle)
	var y: float = hand_radius * sin(angle)
	
	return Vector2(x, y)

func _update_card_transform(card: UsuableCard, angle: float) -> void:
	card.set_position(get_card_position(angle))
	card.set_rotation(angle + PI / 2)

func _handle_card_touched(card: Node2D):
	touched.push_back(card)

func _handle_card_untouched(card: Node2D):
	var card_index = hand.find(card)
	touched.remove_at(touched.find(card))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click") && current_selected_card_index >= 0:
		var card = hand[current_selected_card_index]
		# TODO: Depending on what should we do with a card, maybe we could queue.free() now
		card_activated.emit(card)
		current_selected_card_index = -1

func _process(delta: float) -> void:
	for card in hand:
		current_selected_card_index = -1
		if !card.card.clicked:
			card.unhighlight()
	
	if !touched.is_empty():
		var highest_touched_index: int = -1
		
		for touched_card in touched:
			highest_touched_index = max(highest_touched_index, hand.find(touched_card))
			
		if highest_touched_index >= 0 && highest_touched_index < hand.size():
			hand[highest_touched_index].highlight()
			current_selected_card_index = highest_touched_index
	
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius)
