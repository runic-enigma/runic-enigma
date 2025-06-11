extends Node2D

signal button_pressed

@export var debug_mode: bool = true:
	set(value):
		if !is_node_ready():
			await ready
		debug_mode = value
		$Deck.debug_mode = debug_mode

@onready var game_control: GameController = $GameController
@onready var deck_view_window: DeckViewWindow = $CanvasLayer/DeckViewWindow as DeckViewWindow
@onready var deck_with_hand: Node2D = $Deck

var enemy_character_state: int = 0

@onready var berry_bush: CardData = preload("res://card_data/berry_bush.tres")
@onready var fire_ball: CardData = preload("res://card_data/fire_ball.tres")
@onready var frost_bolt = preload("res://card_data/frost_bolt.tres")
@onready var life_flow = preload("res://card_data/life_flow.tres")
@onready var shield_block = preload("res://card_data/shield_block.tres")

@onready var deck: Deck = PlayerData.deck

var playableDeck: PlayableDeck

func restart_game():
	game_control.current_state = GameController.GameState.PLAYER_TURN
	$GameScreen/PlayerCharacter.reset()
	$GameScreen/EnemyCharacter.reset()
	deck_with_hand.reset()
	deck = Deck.new()
	deck.add_card(berry_bush)
	deck.add_card(fire_ball)
	deck.add_card(frost_bolt)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(fire_ball)
	deck.add_card(life_flow)
	deck.add_card(shield_block)
	playableDeck = PlayerData.deck.get_playable_deck()
	playableDeck.shuffle()
	
	deck_with_hand.add_card(playableDeck.draw_card())
	deck_with_hand.add_card(playableDeck.draw_card())
	deck_with_hand.add_card(playableDeck.draw_card())
	deck_with_hand.add_card(playableDeck.draw_card())
	deck_with_hand.add_card(playableDeck.draw_card())
	
func _ready():
	
	$"../Music".play()
	
	game_control.current_state = GameController.GameState.PLAYER_TURN
	PlayerData.start_turn()
	playableDeck = PlayerData.deck.get_playable_deck()
	playableDeck.shuffle()
	
	deck_with_hand.deck = deck
	
	deck_with_hand.add_card(playableDeck.draw_card())
	deck_with_hand.add_card(playableDeck.draw_card())
	deck_with_hand.add_card(playableDeck.draw_card())
	deck_with_hand.add_card(playableDeck.draw_card())
	deck_with_hand.add_card(playableDeck.draw_card())
	
	
func _process(delta: float) -> void:
	if !game_control.is_running:
		return
	
	$ManaAmount.set_text(str(PlayerData.mana))
	$GameScreen/PlayerCharacter.health = PlayerData.health
	$GameScreen/PlayerCharacter.update_health_bar()
	
	var enemies = $GameScreen/Enemies.get_children()
	for enemy in enemies:
		if enemy.health <= 0:
			enemy.queue_free()
	
	if PlayerData.health <= 0:
		game_control.transition(GameController.GameState.GAMEOVER)
	elif !$GameScreen/Enemies.get_children():
			$Button.show()
			$EndTurn.hide()
			$Deck.hide()
			
	if game_control.current_state == GameController.GameState.ENEMY_TURN:
		if enemy_character_state == 0:
			PlayerData.take_damage(3)
		elif enemy_character_state == 1:
			PlayerData.take_damage(2)
		elif enemy_character_state == 2:
			PlayerData.take_damage(1)
		
		$"../CharacterHit".play()

		enemy_character_state = posmod(enemy_character_state + 1, 3)
		game_control.transition(GameController.GameState.PLAYER_TURN)
		var card_with_id = playableDeck.draw_card()
		
		if card_with_id:
			deck_with_hand.add_card(card_with_id)
		
		PlayerData.start_turn()
		
	if game_control.current_state == GameController.GameState.VICTORY:
		$CanvasLayer/VictoryOverlay.show()
	else:
		$CanvasLayer/VictoryOverlay.hide()
		
	if game_control.current_state == GameController.GameState.GAMEOVER:
		$CanvasLayer/GameOverOverlay.show()
		
func _input(event: InputEvent) -> void:
	if event.is_action("restart"):
		restart_game()
		
func _on_deck_card_activated(card: UsuableCard) -> void:
	var card_cost: int = card.get_cost()
	if card_cost <= PlayerData.mana:
		var enemy = null
		if card.get_type() == PlayerData.Type.ATTACK:
			card.card.clicked = true
			var enemies_container = $GameScreen/Enemies
			
			for enemy_child in enemies_container.get_children():
				enemy = await enemy_child.character_clicked
				break
		else:
			enemy = null
			
		if card.get_type() == PlayerData.Type.ATTACK:
			$"../Hit".play()
			$GameScreen/PlayerCharacter/AnimatedSprite2D.play("deal_damage")
			
		card.card.clicked = false
		card.activate({
			"caster": PlayerData,
			"targets": [enemy]
		})
		$Deck.remove_card(card)
		card.queue_free()


func _on_end_turn_pressed() -> void:
	$"../ClickSound".play()
	
	if game_control.current_state == GameController.GameState.PLAYER_TURN:
		game_control.transition(GameController.GameState.ENEMY_TURN)
		var enemies = $GameScreen/Enemies.get_children()
		var enemy = enemies.pick_random()
		enemy.start_turn()

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


func _on_button_pressed() -> void:
	$"../ClickSound".play()
	
	button_pressed.emit()
