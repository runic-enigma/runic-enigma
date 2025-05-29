extends Node2D

@export var debug_mode: bool = true:
	set(value):
		if !is_node_ready():
			await ready
		debug_mode = value
		$Deck.debug_mode = debug_mode

@onready var game_control: GameController = $GameController
@onready var deck_view_window: DeckViewWindow = $CanvasLayer/DeckViewWindow as DeckViewWindow
@onready var deck_ui: PlayableDeckUI = $PlayableDeckUi
@onready var deck_with_hand: Node2D = $Deck

var enemy_character_state: int = 0

@onready var deck: Deck = Deck.new()

func restart_game():
	game_control.current_state = GameController.GameState.PLAYER_TURN
	$GameScreen/PlayerCharacter.reset()
	$GameScreen/EnemyCharacter.reset()
	deck_with_hand.reset()
	deck_ui.deck = deck.get_playable_deck()
	deck_ui.show()
	
func _ready():
	deck_with_hand.deck = deck
	
func _process(delta: float) -> void:
	if !game_control.is_running:
		return
	
	$ManaAmount.set_text(str($GameScreen/PlayerCharacter.mana))
	
	if $GameScreen/PlayerCharacter.health <= 0:
		game_control.transition(GameController.GameState.GAMEOVER)
	elif $GameScreen/EnemyCharacter.health <= 0:
		game_control.transition(GameController.GameState.VICTORY)
		
	
	if game_control.current_state == GameController.GameState.ENEMY_TURN:
		if enemy_character_state == 0:
			$GameScreen/PlayerCharacter.take_damage(3)
		elif enemy_character_state == 1:
			$GameScreen/PlayerCharacter.take_damage(2)
		elif enemy_character_state == 2:
			$GameScreen/PlayerCharacter.take_damage(1)

		enemy_character_state = posmod(enemy_character_state + 1, 3)
		game_control.transition(GameController.GameState.PLAYER_TURN)
		$GameScreen/PlayerCharacter.start_turn()
		
	if game_control.current_state == GameController.GameState.VICTORY:
		$CanvasLayer/VictoryOverlay.show()
	else:
		$CanvasLayer/VictoryOverlay.hide()
		
	if game_control.current_state == GameController.GameState.GAMEOVER:
		$CanvasLayer/GameOverOverlay.show()
	else:
		$CanvasLayer/GameOverOverlay.hide()
		
func _input(event: InputEvent) -> void:
	if event.is_action("restart"):
		restart_game()
		
func _on_deck_card_activated(card: UsuableCard) -> void:
	var card_cost: int = card.get_cost()
	if card_cost <= $GameScreen/PlayerCharacter.mana:
		card.activate({
			"caster": $GameScreen/PlayerCharacter,
			"targets": [$GameScreen/EnemyCharacter]
		})
		$Deck.remove_card(card)
		card.queue_free()


func _on_end_turn_pressed() -> void:
	if game_control.current_state == GameController.GameState.PLAYER_TURN:
		game_control.transition(GameController.GameState.ENEMY_TURN)
		$GameScreen/EnemyCharacter.start_turn()

func _on_deck_button_pressed() -> void:
	if deck_view_window.visible:
		deck_view_window.hide()
		game_control.resume()
	else:
		game_control.pause()
		deck_view_window.show()
		deck_view_window.display_card_list(deck.get_cards())


func _on_start_game_pressed() -> void:
	restart_game()

func _on_playable_deck_ui_pressed() -> void:
	var card_with_id = deck_ui.draw()
	
	if card_with_id:
		deck_with_hand.add_card(card_with_id)
