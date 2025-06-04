extends Node

signal level_changed(level_name)

@export var level_name: String = "level"


func _on_home_level_begin_adventure_pressed() -> void:
	level_changed.emit(level_name)
