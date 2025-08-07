class_name BattleManager extends Node

signal turn_ended()
signal battle_ended()

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
# @onready var player_character = $PlayerCharacter
# @onready var enemies = $Enemies

func _ready() -> void:
	print("Battle started! Initializing...")

	turn_ended.connect(_on_turn_ended)

	_transition_to_state(BattleState.BATTLE_SETUP)

func _process(_delta: float) -> void:
	match current_state:
		BattleState.PLAYER_TURN:
			_handle_player_turn()
		BattleState.ENEMY_TURN:
			_handle_enemy_turn()
		_:
			pass

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
