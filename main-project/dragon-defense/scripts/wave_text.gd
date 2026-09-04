extends Node2D

const NUMBER_TEXT = {
	0 : "zero",
	1 : "one",
	2 : "two",
	3 : "three",
	4 : "four",
	5 : "five"
}










# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position.y = 700
	global_position.x = 576


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.y -= delta * 200
	if global_position.y == -100:
		queue_free()
				
	
	
