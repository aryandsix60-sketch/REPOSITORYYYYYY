extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.in_game = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _play_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/level.tscn")
