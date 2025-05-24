@tool
class_name Character extends Area2D

@export var max_health: int = 10
@export var health: int = 10

func set_health_values(health: int, max_health: int):
	self.health = health
	self.max_health = max_health
	update_health_bar()
	
func update_health_bar():
	if ($HealthBar as ProgressBar).max_value != max_health:
		($HealthBar as ProgressBar).max_value = max_health
	if ($HealthBar as ProgressBar).value != health:
		($HealthBar as ProgressBar).value = health

func _process(delta: float) -> void:
	update_health_bar()
