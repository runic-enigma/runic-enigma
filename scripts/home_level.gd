extends Node2D

signal begin_adventure_pressed

func _on_button_pressed() -> void:
	
	$Click.play()
	PlayerData.reset_data()
	
	emit_signal("begin_adventure_pressed")
