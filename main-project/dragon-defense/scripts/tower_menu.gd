extends Control

@export var damage_level_display : Button
@export var range_level_display : Button
@export var rate_level_display : Button

var tower

var damage_level
var range_level
var rate_level

var damage_level_cost : float = 10
var range_level_cost : float = 10
var rate_level_cost : float = 10





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	damage_level_display.text = str(damage_level)
	range_level_display.text = str(range_level)
	rate_level_display.text = str(rate_level)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_close_pressed() -> void:
	global.tower_menu_active = false
	queue_free()
	


func _on_damage_level_up_pressed() -> void:
	if global.coins >= damage_level_cost:
		damage_level += 1
		tower.damage_level = damage_level
		damage_level_display.text = str(damage_level)
		global.coins -= damage_level_cost
		damage_level_cost += 20
		


func _on_range_level_up_pressed() -> void:
	range_level += 1
	tower.range_level = range_level
	range_level_display.text = str(range_level)


func _on_rate_level_up_pressed() -> void:
	rate_level += 1
	tower.rate_level = rate_level
	rate_level_display.text = str(rate_level)
