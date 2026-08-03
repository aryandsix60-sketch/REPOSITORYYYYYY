extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#identifying the variables original value
	$circle.frame = 0

	global.tower_creation_possible = true
	global.tower_placer_active = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if global.tower_placer_active == false:
		queue_free()

	#sets the circle to follow the mouse
	global_position = get_global_mouse_position()
	#TOWER PLACEMENT
	if Input.is_action_just_pressed("place_tower") and global.tower_creation_possible and global.tower_placer_active:
		global.tower_creation_possible = false
		global.tower_placer_active = false
		global.place_tower()
		queue_free()

	#END OF TOWER PLACEMENT

#checks when the circle enters the path where it can't be placed
func _disallowed_area_entered(area: Area2D) -> void:
	if area.is_in_group("no_tower_placement"):
		$circle.frame = 1
		global.tower_creation_possible = false
		


#checks when the circle exits the path where it can't be placed
func _disallowed_area_exited(area: Area2D) -> void:
	if area.is_in_group("no_tower_placement"):
		for areas in get_overlapping_areas():
			if areas.is_in_group("no_tower_placement"):
				pass
	else:	
		$circle.frame = 0
		global.tower_creation_possible = true
		print("enabled")
		
#HIIIIIIIIIIIIIIIIIIIII
	
	#CHECK IF TOWER CAN BE PLACED AT ANY TIME
		

		
		
	
