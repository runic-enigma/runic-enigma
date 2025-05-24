extends Node2D


func _on_deck_card_activated(card: UsuableCard) -> void:
	card.activate({
		"caster": $GameScreen/PlayerCharacter,
		"targets": [$GameScreen/EnemyCharacter]
	})
