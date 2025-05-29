extends Node2D

@onready var game_control: GameController = $GameController
@onready var deck_view_window: DeckViewWindow = $CanvasLayer/DeckViewWindow as DeckViewWindow

var enemy_character_state: int = 0

@onready var deck: Deck = Deck.new()

func restart_game():
	game_control.current_state = GameController.GameState.PLAYER_TURN
	$GameScreen/PlayerCharacter.reset()
	$GameScreen/EnemyCharacter.reset()
	$Deck.reset()
	
func _ready():
	$Deck.deck = deck
	
func _process(delta: float) -> void:
	if !game_control.is_running:
		return
	
	$ManaAmount.set_text(str($GameScreen/PlayerCharacter.mana))
	
	if $GameScreen/PlayerCharacter.health <= 0:
		game_control.transition(GameController.GameState.GAMEOVER)
	elif $GameScreen/EnemyCharacter.health <= 0:
		game_control.transition(GameController.GameState.VICTORY)
		
	
	if game_control.current_state == GameController.GameState.ENEMY_TURN:
		#AI LOGIC
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
	pass # Replace with function body.


func _on_deck_button_pressed() -> void:
	game_control.pause()
	deck_view_window.show()
	deck_view_window.display_card_list(deck.get_cards())
