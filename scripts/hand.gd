@tool
class_name Hand extends Node2D

@export var hand_radius: int = 100
@export var card_angle: float = PI / 2
@export var angle_limit: float = PI / 24
@export var max_card_spread_angle: float = PI / 24

@onready var test_card = $TestCard
@onready var collision_shape: CollisionShape2D = $DebugShape

var hand: Array = []

func add_card(card: Node2D):
	hand.push_back(card)
	add_child(card)
	reposition_cards()
	
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

func _process(delta: float) -> void:
	
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius)

	test_card.set_position(get_card_position(card_angle))
	test_card.set_rotation(card_angle + PI / 2)
