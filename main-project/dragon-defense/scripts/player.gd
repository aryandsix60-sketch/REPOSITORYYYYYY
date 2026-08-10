extends CharacterBody2D
@export var player = CharacterBody2D
var health = int(3)
var can_shoot: bool = true
var score = int(0)
var direction: Vector2 = Vector2(0.0, 0.0)
var speed = float(300)
@export var pivot: Node2D
@export var bullet_spawn: Marker2D
@export var flash_scene: PackedScene
@export var flash_spawn: Marker2D
@export var timer: Timer
var level 
var multi_shoot: bool = false
@export var multi_time: Timer
@export var bullet_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1
	z_index = 20
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$BackRotor.global_position = $HelicopterBody/back_rotor_pos.global_position
	$MainRotor.rotation += (20*delta)
	$BackRotor.rotation += (20*delta)
	
	
	
	
	
	
	
	
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	

	velocity = speed * direction.normalized()

	pivot.look_at(get_global_mouse_position())
	$HelicopterBody.look_at(get_global_mouse_position())
	
	
	
	if Input.is_action_pressed("ui_shoot") and can_shoot and not global.tower_placer_active:
		_shoot()
	
	
	
	
	move_and_slide()
		





func _shoot() -> void:
	var angles
	if multi_shoot == true:
		angles = [0, -20, 20, -40, 40]		
	elif multi_shoot == false: 
		angles = [0]
	for angle in angles:
		var bullet = bullet_scene.instantiate()
		bullet.rotation = pivot.rotation + deg_to_rad(angle)
		bullet.global_position = bullet_spawn.global_position
		add_sibling(bullet)
	
	

	
	
	
	can_shoot = false
	timer.start()
	


func _reload_time() -> void:
	can_shoot = true
	

	
	
func multishot_enable() -> void:
	multi_time.start()
	multi_shoot = true




func _multi_expire() -> void:
	multi_shoot = false
