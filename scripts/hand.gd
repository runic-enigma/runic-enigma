@tool
class_name Hand extends Node2D

@export var hand_radius: int = 100
@export var card_angle: float = PI / 2
@export var angle_limit: float = PI / 6
@export var max_card_spread_angle: float = PI / 16

@onready var test_card = $TestCard
@onready var collision_shape: CollisionShape2D = $DebugShape

var hand: Array = []
var touched: Array = []
var current_selected_card_idnex: int = -1

func add_card(card: Node2D) -> void: 
	hand.push_back(card)
	add_child(card)
	card.mouse_entered.connect(_handle_card_touched)
	card.mouse_exited.connect(_handle_card_untouched)
	reposition_cards()
	
func remove_card(index: int) -> Node2D:
	var removing_card = hand[index]
	hand.remove_at(index)
	remove_child(removing_card)
	reposition_cards()
	return removing_card
	
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

func _update_card_transform(card: Node2D, angle: float) -> void:
	card.set_position(get_card_position(angle))
	card.set_rotation(angle + PI / 2)

func _handle_card_touched(card: Node2D):
	touched.push_back(card)

func _handle_card_untouched(card: Node2D):
	var card_index = hand.find(card)
	touched.remove_at(touched.find(card))

func _process(delta: float) -> void:
	for card in hand:
		current_selected_card_idnex = -1
		card.unhighlight()
	
	if !touched.is_empty():
		var highest_touched_index: int = -1
		
		for touched_card in touched:
			highest_touched_index = max(highest_touched_index, hand.find(touched_card))
			
		if highest_touched_index >= 0 && highest_touched_index < hand.size():
			hand[highest_touched_index].highlight()
			current_selected_card_idnex = highest_touched_index
	
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius)

	test_card.set_position(get_card_position(card_angle))
	test_card.set_rotation(card_angle + PI / 2)
