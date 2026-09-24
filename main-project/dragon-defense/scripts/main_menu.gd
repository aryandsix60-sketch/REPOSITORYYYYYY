extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.in_game = false


func _play_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/level.tscn")
