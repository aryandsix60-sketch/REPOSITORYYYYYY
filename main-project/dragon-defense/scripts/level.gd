extends Node2D
@export var spawner: Marker2D
var scene_enemies = {
	"scorpions" : [],
	"wizards" : [],
	"robots" : [],
	"ogres" : [],
	"ogre_tanks" : []
}



var current_wave

var scenes = {
	"scorpion" : preload("res://scenes/scorpion.tscn"),
	"wizard" : preload("res://scenes/wizard.tscn"),
	"ogre" : preload("res://scenes/ogre.tscn"),
	"robot" : preload("res://scenes/robot.tscn"),
	"ogre_tank" : preload("res://scenes/ogre_tank.tscn")

	}

var waves = {
	"1": {
		"scorpion" : [5,0,3,1],
		"wizard": [0,1,0,0],
		"ogre" : [1,0,1,0],
		"robot" : [0,0,0,1],
		"ogre_tank" : [0,0,0,1]
		},
	"2": {
		"scorpion" : 15,
		"wizard": 1,
		"ogre" : 1,
		"robot" : 0,
		"ogre_tank" : 0
		},
	"3": {
		"scorpion" : 20,
		"wizard": 2,
		"ogre" : 0,
		"robot" : 1,
		"ogre_tank" : 0
		},
	"4": {
		"scorpion" : 30,
		"wizard": 1,
		"ogre" : 0,
		"robot" : 0,
		"ogre_tank" : 0
		},
	
		}







# Called when the node enters the scene tree for the first time.
func _ready() -> void:


	_start_wave()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
		
func _start_wave() -> void:
	var enemy_number = scene_enemies["scorpions"].size()
	current_wave = str(global.wave)
	var wave = waves[current_wave]

	var max_sub_wave = wave["scorpion"].size()

	for sub_wave in range(max_sub_wave):
		for enemy in wave:
			var amount = wave[enemy][sub_wave]

			for i in range(amount):
				
				var enemy_name = str(enemy + "s")

				enemy_number += 1
				scene_enemies[enemy_name].append(enemy + str((enemy_number)))

				
				var enemies = scenes[enemy].instantiate()
				enemies.enemy_no = enemy_number
				enemies.global_position = $spawner.global_position
				$Path2D.add_child(enemies)

				await get_tree().create_timer(0.5).timeout

		await get_tree().create_timer(0.5).timeout


				
			




func _rotate(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.get_parent().rotate_enemy()
