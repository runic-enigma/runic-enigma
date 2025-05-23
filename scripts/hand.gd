@tool
extends Node2D

@export var hand_radius: int = 100
@export var card_angle: float = PI / 2

@onready var test_card = $TestCard
@onready var collision_shape: CollisionShape2D = $DebugShape

# IMPORTANT: angle is in radians
func get_card_position(angle: float) -> Vector2:
	var x: float = hand_radius * cos(angle)
	var y: float = hand_radius * sin(angle)
	
	return Vector2(x, y)
		
func _process(delta: float) -> void:
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius)

	test_card.set_position(get_card_position(card_angle))
	test_card.set_rotation(card_angle + PI / 2)
