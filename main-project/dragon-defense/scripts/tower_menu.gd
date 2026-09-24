extends Control

@export var damage_level_display : Button
@export var range_level_display : Button
@export var rate_level_display : Button

var tower : CharacterBody2D
var damage_level: int
var range_level: int
var rate_level: int
var damage_level_cost: int
var range_level_cost: int
var rate_level_cost: int
var damage_level_cap: bool = false
var range_level_cap: bool = false
var rate_level_cap: bool = false
var damage_power: float = 1.5
var range_power: float = 1.6
var rate_power: float = 1.7

const MENU_Z_INDEX: int = 500
const DOLLAR_SIGN_ADDER: String = "$"
const COST_MULTIPLIER: float = 10
const MAX_TOWER_LEVEL: int = 10

@onready var damage_cost_label: Label = $Panel/damage/damage_level_up/damage_upgrade_cost
@onready var range_cost_label: Label = $Panel/range/range_level_up/range_upgrade_cost
@onready var rate_cost_label: Label = $Panel/rate/rate_level_up/rate_upgrade_cost
@onready var damage_image: Panel = $Panel/damage/damage_level_up/damage_level_up_image
@onready var range_image: Panel = $Panel/range/range_level_up/range_level_up_image
@onready var rate_image: Panel = $Panel/rate/rate_level_up/rate_level_up_image



func _ready() -> void:
	z_index = MENU_Z_INDEX

	damage_level_display.text = str(damage_level)
	range_level_display.text = str(range_level)
	rate_level_display.text = str(rate_level)


func _process(_delta: float) -> void:
	damage_level_cost = int(COST_MULTIPLIER * pow(damage_power, damage_level))
	range_level_cost = int(COST_MULTIPLIER * pow(range_power, range_level))
	rate_level_cost = int(COST_MULTIPLIER * pow(rate_power, rate_level))

	damage_cost_label.text = DOLLAR_SIGN_ADDER + str(int(damage_level_cost))
	range_cost_label.text = DOLLAR_SIGN_ADDER + str(int(range_level_cost))
	rate_cost_label.text = DOLLAR_SIGN_ADDER + str(int(rate_level_cost))

	if damage_level == MAX_TOWER_LEVEL:
		damage_level_cap = true
		damage_cost_label.show()
		damage_cost_label.text = "MAX"
		damage_image.hide()

	if range_level == MAX_TOWER_LEVEL:
		range_level_cap = true
		range_cost_label.text = " MAX"
		range_image.hide()
		range_cost_label.show()


	if rate_level == MAX_TOWER_LEVEL:
		rate_level_cap = true
		rate_cost_label.text = " MAX"
		rate_image.hide()
		rate_cost_label.show()




func _on_damage_level_up_pressed() -> void:
	if global.coins >= damage_level_cost and not damage_level_cap:
		damage_level += 1
		tower.damage_level = damage_level
		damage_level_display.text = str(damage_level)
		global.coins -= damage_level_cost



func _on_range_level_up_pressed() -> void:
	if global.coins >= range_level_cost and not range_level_cap:
		range_level += 1
		tower.range_level = range_level
		range_level_display.text = str(range_level)
		global.coins -= range_level_cost
		tower.range_level_increased()


func _on_rate_level_up_pressed() -> void:
	if global.coins >= rate_level_cost and not rate_level_cap:
		rate_level += 1
		tower.rate_level = rate_level
		rate_level_display.text = str(rate_level)
		global.coins -= rate_level_cost
		tower.rate_level_increased()



func _on_damage_level_up_mouse_entered() -> void:
	if not damage_level_cap:
		damage_image.hide()
		damage_cost_label.show()


func _on_damage_level_up_mouse_exited() -> void:
	if not damage_level_cap:
		damage_image.show()
		damage_cost_label.hide()


func _on_range_level_up_mouse_entered() -> void:
	if not range_level_cap:
		range_image.hide()
		range_cost_label.show()


func _on_range_level_up_mouse_exited() -> void:
	if not range_level_cap:
		range_image.show()
		range_cost_label.hide()


func _on_rate_level_up_mouse_entered() -> void:
	if not rate_level_cap:
		rate_image.hide()
		rate_cost_label.show()


func _on_rate_level_up_mouse_exited() -> void:
	if not rate_level_cap:
		rate_image.show()
		rate_cost_label.hide()



func _exit() -> void:

	queue_free()
	global.tower_menu_active = false
