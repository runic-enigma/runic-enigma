extends Node

enum Type {
	ATTACK,
	DEFENSE
}

@export var max_health: int = 10
@export var starting_mana: int = 10
@export var base_armor: int = 0
@export var mana_cap: int = 10

var health: int = 10
var mana: int = 10
var armor: int = 0
var player_deck = []

var deck = Deck.new()

@onready var berry_bush: CardData = preload("res://card_data/berry_bush.tres")
@onready var fire_ball: CardData = preload("res://card_data/fire_ball.tres")
@onready var frost_bolt = preload("res://card_data/frost_bolt.tres")
@onready var life_flow = preload("res://card_data/life_flow.tres")
@onready var shield_block = preload("res://card_data/shield_block.tres")

func _ready() -> void:
	deck.add_card(berry_bush)
	deck.add_card(fire_ball)
	deck.add_card(frost_bolt)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(life_flow)
	deck.add_card(shield_block)
	
	mana = mana_cap

func reset_data():
	pass

func spend_mana(amount: int) -> void:
	mana -= amount
	
func take_damage(amount: int) -> void:
	health -= amount

func add_armor(amount: int) -> void:
	armor += amount
	
func add_health(amount: int) -> void:
	health += amount 
	if health > max_health:
		health = max_health
	
func start_turn():
	armor = 0
	mana = mana_cap
