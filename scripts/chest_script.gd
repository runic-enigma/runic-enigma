extends Node2D


func _on_area_2d_enemy_selected(enemy: Variant) -> void:
	$"../../CanvasLayer/CardOverlay".show()
	$"../../../ClickSound".play()
	enemy.queue_free()
