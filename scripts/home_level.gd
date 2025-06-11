extends Node2D

signal begin_adventure_pressed

func _on_button_pressed() -> void:
	
	$Click.play()
	
	emit_signal("begin_adventure_pressed")
