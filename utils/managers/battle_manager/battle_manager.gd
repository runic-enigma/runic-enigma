"""
BattleManager class is a class required for every battle scene. It contains the state and logic for a battle. For altering the state use signals from battle_events.
"""
class_name BattleManager extends Node

# To be defined
enum BattleState {
	BATTLE_SETUP,
	PLAYER_TURN,
	PLAYER_CARD_PLAYING,
	PLAYER_TURN_END,
	ENEMY_TURN,
	ENEMY_TURN_END,
	BATTLE_END
}

var current_state: BattleState = BattleState.BATTLE_SETUP

# To be discussed
@export var player_character: Node2D
@export var enemies: Node2D

func _ready() -> void:
	print("Battle started! Initializing...")
	var battle_events: BattleEvents = get_tree().get_first_node_in_group("battle_events")
	if battle_events:
		battle_events.end_turn.connect(_on_turn_ended)

	_transition_to_state(BattleState.BATTLE_SETUP)

func _transition_to_state(new_state: BattleState) -> void:
	current_state = new_state
	print("Battle state changed to: ", new_state)

	match new_state:
		BattleState.BATTLE_SETUP:
			_setup_battle()
		BattleState.PLAYER_TURN:
			_start_player_turn()
		_:
			pass

func _setup_battle() -> void:
	_transition_to_state(BattleState.PLAYER_TURN)

func _start_player_turn() -> void:
	print("Player turn started!")

func _handle_player_turn() -> void:
	print("Player turn handled!")

func _handle_enemy_turn() -> void:
	print("Enemy turn handled!")

func _on_turn_ended() -> void:
	print("Turn ended")


func _on_state_changed() -> void:
	match current_state:
		BattleState.BATTLE_SETUP:
			_setup_battle()
		BattleState.PLAYER_TURN:
			_handle_player_turn()
		BattleState.PLAYER_CARD_PLAYING:
			pass
		BattleState.PLAYER_TURN_END:
			pass
		BattleState.ENEMY_TURN:
			_handle_enemy_turn()
		BattleState.ENEMY_TURN_END:
			pass
		BattleState.BATTLE_END:
			pass
