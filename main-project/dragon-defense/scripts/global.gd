extends Node

const TOWER_Z_INDEX: int = 1

var tower_menu_active: bool = false
var in_game: bool = false
var tower_creation_possible: bool = false
var tower_placer_active: bool = false
var wave: int = 1
var coins: float = 150
var health: int = 20
var coin_cost: float = 10
var tower_placer_scene: PackedScene = preload("res://scenes/tower_checker.tscn")
var tower_scenes: Array = [preload("res://scenes/tower1.tscn"),preload("res://scenes/tower2.tscn")]
var scene_enemies: Dictionary = {}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Checks if the player is in game or not before spawning the tower placer
	if in_game:
 #If the user just pressed the tower placer input, and its not already active, place the tower
		if Input.is_action_just_pressed("tower_placer") and not tower_placer_active:
# Creates the variable to instantiate the tower
			var tower_placer: Area2D = tower_placer_scene.instantiate()
# Addes the tower to the main scene as a child, which is the level scene
			get_tree().current_scene.add_child(tower_placer)
# Activates the tower placer active variable, to ensure
# That the tower placer isnt spawned in multiple times
			tower_placer_active = true
# If they press the button again, then the code will simply delete the tower placer,
# The tower placer scene is constantly checking if the tower_placer_active var is true,
# And it will queue_free() if it detects this as false
		elif Input.is_action_just_pressed("tower_placer") and tower_placer_active:
			tower_placer_active = false




# If the signal to place the tower is recieved, place the tower
func place_tower(tower_number : int) -> void:
# Creates a var to insantiate the tower
	var tower: CharacterBody2D = tower_scenes[tower_number].instantiate()
# Spawns the tower on the mouse position because that is how the tower place system works
	tower.global_position = get_viewport().get_mouse_position()
# Ensures the tower is infront of certain other elements
	tower.z_index = TOWER_Z_INDEX
# Adds the tower as a child of the level scene
	get_tree().current_scene.add_child(tower)
