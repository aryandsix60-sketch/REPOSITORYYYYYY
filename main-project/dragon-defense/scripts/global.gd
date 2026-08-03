extends Node





var scene_enemies = {
	
}
var tower_creation_possible = false
var tower_placer_scene = preload("res://scenes/tower_checker.tscn")
var tower_placer_active = false
var wave = 1
var tower_scene = preload("res://scenes/tower1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("tower_placer") and not tower_placer_active:
		var tower_placer = tower_placer_scene.instantiate()
		get_tree().current_scene.add_child(tower_placer)
		tower_placer_active = true
	elif Input.is_action_just_pressed("tower_placer") and tower_placer_active:
		tower_placer_active = false
		
		
		
		
		
func place_tower() -> void:
	print("HLEOOOOO")
	var tower = tower_scene.instantiate()
	tower.global_position = get_viewport().get_mouse_position()
	tower.z_index = 1
	get_tree().current_scene.add_child(tower)

		
