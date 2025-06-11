extends Node

signal level_changed(level_name)

@export var level_name: String = "level"



func _on_home_level_begin_adventure_pressed() -> void:
	
	level_changed.emit(level_name)


func _on_main_button_pressed() -> void:
	
	level_changed.emit(level_name)


func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_game_over_begin_adventure_pressed() -> void:
	
	level_changed.emit("room_1")


func _on_main_game_over() -> void:
	level_changed.emit("game_over")


func _on_button_pressed() -> void:
	pass # Replace with function body.


func _on_main_menu_pressed() -> void:
	print("hee?")
	level_changed.emit("home_level")
