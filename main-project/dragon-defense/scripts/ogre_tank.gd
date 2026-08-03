extends PathFollow2D
var speed = 300
var health = 50
@export var health_ui : ProgressBar
var enemy_no

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health
	progress_ratio = 0
	$pivot.scale.x = 1

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed*delta
	if progress > 2530:
		queue_free()
	$pivot/AnimatedSprite2D.play("run")
	
		
func rotate_enemy() -> void:
	$pivot.scale.x = -1
	
func take_damage() -> void:
	if health > 0:
		health -=1
		health_ui.value = health
		
	if health == 0:
		queue_free()
		
	
