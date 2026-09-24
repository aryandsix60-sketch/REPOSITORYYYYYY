extends Area2D

var blocked_areas: int = 0
var place_ready: bool = false
var tower_choice: int = 0
var tower_chosen: int = 0
var towers_placed: int = 0


const MAX_TOWER_CHOICE: int  = 1
const MIN_TOWER_CHOICE: int  = 0
const COIN_MULTI: float = 2


func _ready() -> void:
	$tower_shadow.frame = 1
	$circle.frame = 1
	global.tower_creation_possible = false
	global.tower_placer_active = true
	if blocked_areas >= 1:
		$circle.frame = 1
	place_ready = true
	#identifying the variables original value


func _process(_delta: float) -> void:

	print(global.coin_cost)
	$tower_shadow.frame = tower_choice
	if Input.is_action_just_pressed("change_tower") and global.tower_placer_active:
		if tower_choice == MAX_TOWER_CHOICE:
			tower_choice = MIN_TOWER_CHOICE
		else:
			tower_choice += 1




	if global.tower_placer_active == false:
		queue_free()
	#sets the circle to follow the mouse
	global_position = get_global_mouse_position()
	#TOWER PLACEMENT
	if place_ready:
		if (Input.is_action_just_pressed("place_tower") and global.tower_creation_possible
				and global.tower_placer_active and global.coins >= global.coin_cost):
			global.coins -= global.coin_cost
			global.coin_cost = global.coin_cost * COIN_MULTI

			global.tower_creation_possible = false
			global.tower_placer_active = false
			global.place_tower(tower_choice)
			queue_free()

		if blocked_areas >= 1:
			$circle.frame = 1
			global.tower_creation_possible = false
		else:
			$circle.frame = 0
			global.tower_creation_possible = true



		#END OF TOWER PLACEMENT

#checks when the circle enters the path where it can't be placed
func _disallowed_area_entered(area: Area2D) -> void:
	if area.is_in_group("no_tower_placement"):
		blocked_areas += 1

#checks when the circle exits the path where it can't be placed
func _disallowed_area_exited(area: Area2D) -> void:
	if area.is_in_group("no_tower_placement"):
		blocked_areas -=1


	#CHECK IF TOWER CAN BE PLACED AT ANY TIME
