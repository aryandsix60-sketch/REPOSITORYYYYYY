extends Node2D

const PLURALIZER: String = "s"
const WAVE_TIMER: float = 0.5
var ui_z_index: float = 100
var max_wave: int = 4
var wave_in_progress: bool = false
var current_wave

var scene_enemies = {
	"scorpions" : [],
	"wizards" : [],
	"robots" : [],
	"ogres" : [],
	"ogre_tanks" : []
}
var scenes = {
	"scorpion" : preload("res://scenes/scorpion.tscn"),
	"wizard" : preload("res://scenes/wizard.tscn"),
	"ogre" : preload("res://scenes/ogre.tscn"),
	"robot" : preload("res://scenes/robot.tscn"),
	"ogre_tank" : preload("res://scenes/ogre_tank.tscn")
}
var waves = {
	"1": {
		"scorpion" : [5,0,3,6],
		"wizard": [0,1,0,0],
		"ogre" : [0,0,0,0],
		"robot" : [0,0,0,1],
		"ogre_tank" : [0,0,0,1]
		},
	"2": {
		"scorpion" : [5,4,4,4],
		"wizard": [1,1,1,1],
		"ogre" : [3,3,3,3],
		"robot" : [1,1,1,1],
		"ogre_tank" : [0,1,1,2]
		},
	"3": {
		"scorpion" : [0,4,4,4],
		"wizard": [1,1,1,1],
		"ogre" : [3,3,3,3],
		"robot" : [1,1,1,1],
		"ogre_tank" : [0,1,1,2]
		},
	"4": {
		"scorpion" : [5,4,4,4],
		"wizard": [1,1,1,1],
		"ogre" : [3,3,3,3],
		"robot" : [1,1,1,1],
		"ogre_tank" : [0,1,1,2]
		},
}

@export var coin_label: Label
@export var health_label: Label
@export var health_sprite: Sprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_sprite.z_index = ui_z_index
	health_label.z_index = ui_z_index
	coin_label.z_index = ui_z_index
	#Lets the game know that we are in the game and out of the menu
	global.in_game = true
	#Starts the wave



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	health_label.text = str(global.health)
	
	
	
	
	
	
	
	
	
	

	if Input.is_action_just_pressed("start_wave") and not wave_in_progress:
		_start_wave()
	

	
# Identifies the coin label text so that the player will always know how many coins they have
	coin_label.text = "$"+str(global.coins)
		
		
# Starts the wave
func _start_wave() -> void:
		if global.wave > max_wave or wave_in_progress:
			return
		wave_in_progress = true

		# Gives enemy number its starting value
		var enemy_number = scene_enemies["scorpions"].size()
		# Gets the current wave from the global script
		current_wave = str(global.wave)
		# Gives the wave var the sub list for the wave that is currently happening
		var wave = waves[current_wave]
		# Checks how many subwaves there are, and gives that value to the var, max_sub_wave
		var max_sub_wave = wave["scorpion"].size()
		# Iterates through each sub wave with the value needed for that sub wave.
		for sub_wave in range(max_sub_wave):
		# Iterates through every enemy in that wave
			for enemy in wave:
			# Identifies the amount of each enemy is in this sub wave
				var amount = wave[enemy][sub_wave]
			# Iterates throguh each enemy 
				for i in range(amount):
	# Identifies the enemy name variable and adds an "s" at the end because it needs to match the list 
					var enemy_name = str(enemy + PLURALIZER)
	# Add one to enemy number because enemy will be insantiated
					enemy_number += 1
	# Adds the enemy name to the list as well as their number so each enemy can be tracked easily.
					scene_enemies[enemy_name].append(enemy + str((enemy_number)))
	# Creates the var to instantiate the enemy
					var enemies = scenes[enemy].instantiate()
	# gives the enemy their number
					enemies.enemy_no = enemy_number
	# Gives the enemy it's position to spawn into
					enemies.progress = 0
	# Spawns the enemy as a child of the Path2D, as their root nodes are PathFollow2D.
					$Path2D.add_child(enemies)
	# Wait before spawning more enemies.
					await get_tree().create_timer(WAVE_TIMER).timeout
	# Wait before spawning the next sub wave.
				await get_tree().create_timer(WAVE_TIMER).timeout


		wave_in_progress = false
		global.wave += 1



					
				




func _rotate(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.get_parent().rotate_enemy()
