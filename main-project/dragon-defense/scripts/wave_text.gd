extends Node2D

const NUMBER_TEXT = {
	0 : "ZERO",
	1 : "ONE",
	2 : "TWO",
	3 : "THREE",
	4 : "FOUR",
	5 : "FIVE"
}

@export var wave_text_label : Label








# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position.y = 700
	global_position.x = 576


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wave_text_label.text = "WAVE " + NUMBER_TEXT[global.wave]
	
	global_position.y -= delta * 500
	if global_position.y == -100:
		queue_free()
				
	
	
