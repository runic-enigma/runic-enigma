@tool
class_name Character extends Node2D

signal character_clicked(character)

@export var max_health: int = 10
@export var starting_mana: int = 3
@export var base_armor: int = 0
@export var mana_cap: int = 3

var health: int = 10
var mana: int = 3
var armor: int = 0

func _ready() -> void:
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.play()
	reset()

func set_health_values(health: int, max_health: int):
	self.health = health
	self.max_health = max_health
	update_health_bar()
	
func spend_mana(amount: int) -> void:
	mana -= amount
	
func take_damage(amount: int) -> void:
	$AnimatedSprite2D.animation = "take_damage"
	health -= amount

func add_armor(amount: int) -> void:
	armor += amount
	
func add_health(amount: int) -> void:
	health += amount 
	if health > max_health:
		health = max_health
	
func start_turn():
	armor = 0
	mana = mana_cap
	
func reset():
	health = max_health
	mana = starting_mana
	armor = base_armor
	
func update_health_bar():
	if ($HealthBar as ProgressBar).max_value != max_health:
		($HealthBar as ProgressBar).max_value = max_health
	if ($HealthBar as ProgressBar).value != health:
		($HealthBar as ProgressBar).value = health

func _process(delta: float) -> void:
	update_health_bar()
	
func _on_area_2d_enemy_selected(enemy: Variant) -> void:
	print("boss clicked")
	character_clicked.emit(self)


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "take_damage":
		$AnimatedSprite2D.animation = "default"
