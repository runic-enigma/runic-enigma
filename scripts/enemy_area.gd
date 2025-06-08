extends Area2D

signal enemy_selected(enemy)

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_click"):
		enemy_selected.emit($"..")
