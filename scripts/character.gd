@tool
class_name Character extends Node2D

@export var max_health: int = 10
@export var health: int = 10
@export var mana: int = 10
@export var armor: int = 0

func set_health_values(health: int, max_health: int):
	self.health = health
	self.max_health = max_health
	update_health_bar()
	
func spend_mana(amount: int) -> void:
	mana -= amount
	
func take_damage(amount: int) -> void:
	health -= amount

func add_armor(amount: int) -> void:
	armor += amount
	
func update_health_bar():
	if ($HealthBar as ProgressBar).max_value != max_health:
		($HealthBar as ProgressBar).max_value = max_health
	if ($HealthBar as ProgressBar).value != health:
		($HealthBar as ProgressBar).value = health

func _process(delta: float) -> void:
	update_health_bar()
