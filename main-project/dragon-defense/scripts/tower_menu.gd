extends Control

@export var damage_level_display : Button
@export var range_level_display : Button
@export var rate_level_display : Button

var tower

var damage_level
var range_level
var rate_level

var damage_level_cost
var range_level_cost
var rate_level_cost


var damage_level_cap = false
var range_level_cap = false
var rate_level_cap = false
 
const MENU_Z_INDEX = 500


func _ready() -> void:
	z_index = MENU_Z_INDEX
	global.coins = 10000
	
	damage_level_display.text = str(damage_level)
	range_level_display.text = str(range_level)
	rate_level_display.text = str(rate_level)


func _process(_delta: float) -> void:
	damage_level_cost = int(10 * pow(1.5, damage_level))
	range_level_cost = int(10 * pow(1.6, range_level))
	rate_level_cost = int(10 * pow(1.7, rate_level))
	
	$Panel/damage/damage_level_up/damage_upgrade_cost.text = "$" + str(int(damage_level_cost))
	$Panel/range/range_level_up/range_upgrade_cost.text = "$" + str(int(range_level_cost))
	$Panel/rate/rate_level_up/rate_upgrade_cost.text = "$" + str(int(rate_level_cost))
	
	if damage_level == 10:
		damage_level_cap = true
		$Panel/damage/damage_level_up/damage_upgrade_cost.show()
		$Panel/damage/damage_level_up/damage_upgrade_cost.text = "MAX"
		$Panel/damage/damage_level_up/damage_level_up_image.hide()
	
	if range_level == 10:
		range_level_cap = true
		$Panel/range/range_level_up/range_upgrade_cost.text = " MAX"
		$Panel/range/range_level_up/range_level_up_image.hide()
		$Panel/range/range_level_up/range_upgrade_cost.show()	
		
		
	if rate_level == 10:
		rate_level_cap = true
		$Panel/rate/rate_level_up/rate_upgrade_cost.text = " MAX"
		$Panel/rate/rate_level_up/rate_level_up_image.hide()
		$Panel/rate/rate_level_up/rate_upgrade_cost.show()


func _on_close_pressed() -> void:
	global.tower_menu_active = false
	queue_free()


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
		$Panel/damage/damage_level_up/damage_level_up_image.hide()
		$Panel/damage/damage_level_up/damage_upgrade_cost.show()


func _on_damage_level_up_mouse_exited() -> void:
	if not damage_level_cap:
		$Panel/damage/damage_level_up/damage_level_up_image.show()
		$Panel/damage/damage_level_up/damage_upgrade_cost.hide()


func _on_range_level_up_mouse_entered() -> void:
	if not range_level_cap:
		$Panel/range/range_level_up/range_level_up_image.hide()
		$Panel/range/range_level_up/range_upgrade_cost.show()


func _on_range_level_up_mouse_exited() -> void:
	if not range_level_cap:
		$Panel/range/range_level_up/range_level_up_image.show()
		$Panel/range/range_level_up/range_upgrade_cost.hide()


func _on_rate_level_up_mouse_entered() -> void:
	if not rate_level_cap:
		$Panel/rate/rate_level_up/rate_level_up_image.hide()
		$Panel/rate/rate_level_up/rate_upgrade_cost.show()


func _on_rate_level_up_mouse_exited() -> void:
	if not rate_level_cap:
		$Panel/rate/rate_level_up/rate_level_up_image.show()
		$Panel/rate/rate_level_up/rate_upgrade_cost.hide()
