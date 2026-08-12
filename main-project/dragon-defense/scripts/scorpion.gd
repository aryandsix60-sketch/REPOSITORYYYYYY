extends PathFollow2D
const SPEED: float = 300.0
const MAX_PROGRESS: float = 2530
const SCALE_LEFT: int = 1
const SCALE_RIGHT: int = -1
const START_PROGRESS: int = 0


var health = 2
var enemy_no
var damage = 1



@export var health_ui : ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_ui.max_value = health
	health_ui.value = health
	progress_ratio = START_PROGRESS
	$pivot.scale.x = SCALE_LEFT

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += SPEED * delta
	if progress > MAX_PROGRESS:
		queue_free()
	$pivot/AnimatedSprite2D.play("run")
	
		
func rotate_enemy() -> void:
	$pivot.scale.x = SCALE_RIGHT
	
func take_damage() -> void:
	if health > 0:
		health -= damage
		health_ui.value = health
		
	if health == 0:
		queue_free()
		
	
