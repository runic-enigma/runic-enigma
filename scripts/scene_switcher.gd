extends Node

var next_level = null

@onready var current_level = $HomeLevel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	current_level.level_changed.connect(_handle_level_changed)
	
func _handle_level_changed(level_name: String):
	
	next_level = load("res://scenes/" + level_name + ".tscn").instantiate()
	next_level.z_index = -1
	add_child(next_level)
	animation_player.play("fade_in")
	next_level.level_changed.connect(_handle_level_changed)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade_in":
			current_level.queue_free()
			current_level = next_level
			current_level.z_index = 1
			next_level = null
			animation_player.play("fade_out")
