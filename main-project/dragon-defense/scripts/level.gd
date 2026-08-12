extends Node2D

const PLURALIZER: String = "s"
const WAVE_TIMER: float = 0.5



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
		"scorpion" : [5,0,3,1],
		"wizard": [0,1,0,0],
		"ogre" : [1,0,1,0],
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
		"scorpion" : [5,4,4,4],
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



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.in_game = true

	_start_wave()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	coin_label.text = str(global.coins)
		
func _start_wave() -> void:
	var enemy_number = scene_enemies["scorpions"].size()
	current_wave = str(global.wave)
	var wave = waves[current_wave]

	var max_sub_wave = wave["scorpion"].size()

	for sub_wave in range(max_sub_wave):
		for enemy in wave:
			var amount = wave[enemy][sub_wave]
			for i in range(amount):
				var enemy_name = str(enemy + PLURALIZER)
				enemy_number += 1
				scene_enemies[enemy_name].append(enemy + str((enemy_number)))
				
				var enemies = scenes[enemy].instantiate()
				enemies.enemy_no = enemy_number
				enemies.global_position = $spawner.global_position
				$Path2D.add_child(enemies)

				await get_tree().create_timer(WAVE_TIMER).timeout

		await get_tree().create_timer(WAVE_TIMER).timeout


				
			




func _rotate(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.get_parent().rotate_enemy()
