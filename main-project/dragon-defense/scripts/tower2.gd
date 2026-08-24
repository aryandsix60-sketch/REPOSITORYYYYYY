extends CharacterBody2D
@export var pivot: Node2D
@export var bullet_scene: PackedScene

@export var bullet_spawn: Marker2D
@export var tower_menu_scene: PackedScene
@export var tower_menu_spawn: Marker2D

var can_shoot = true
var target_enemy

var possible_target
var target_enemy_no = 1000
var targetable_enemies = {}
var body_detected
var level = 1

var damage_level = 1
var range_level = 1
var rate_level = 1

var damage
var range_level_radius = [180,200,250,320,380,420,450,480,540,600]
var rate_level_time = [0.7,0.65,0.6,0.55,0.5,0.46,0.42,0.38,0.35,0.32]



@onready var tower_range = $range/range1
@onready var reload = $reload





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation = deg_to_rad(-90)
	tower_range.shape.radius = range_level_radius[range_level - 1]
	reload.wait_time = rate_level_time[rate_level - 1]
	await get_tree().create_timer(0.5).timeout
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
		damage = damage_level
		tower_menu_spawn.global_position = global_position + Vector2(0,-300)
		
		target_enemy_no = 1000
		for enemy_number in targetable_enemies:
			if enemy_number < target_enemy_no:
				target_enemy_no = enemy_number
		if target_enemy_no != 1000:
			target_enemy = targetable_enemies[target_enemy_no]
			var target_angle = global_position.angle_to_point(target_enemy.global_position)
			rotation = rotate_toward(rotation, target_angle, 5.0 * delta)
			if can_shoot:
				shoot()
				
		
		


func _enemy_in_range(body: Node2D) -> void:
	possible_target = body.get_parent()
	if possible_target.is_in_group("enemy"):
		targetable_enemies[possible_target.enemy_no] = possible_target
		
			

func _enemy_out_range(body: Node2D) -> void:
	body_detected = body.get_parent()
	if body_detected.is_in_group("enemy"):
		targetable_enemies.erase(body_detected.enemy_no)


	

		
func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.damage = damage
	bullet.global_position = bullet_spawn.global_position
	bullet.rotation = rotation
	add_sibling(bullet)
	can_shoot = false
	$reload.start()
		

func _open_tower_menu() -> void:
	if not global.tower_menu_active:
		var tower_menu = tower_menu_scene.instantiate()
		tower_menu.damage_level = damage_level
		tower_menu.range_level = range_level
		tower_menu.rate_level = rate_level
		tower_menu.tower = self
		
		add_child(tower_menu)
		

		tower_menu.top_level = true
		tower_menu.global_position = tower_menu_spawn.global_position
		global.tower_menu_active = true


func range_level_increased() -> void:
	$range/range1.shape.radius = range_level_radius[range_level - 1]
	
func rate_level_increased() -> void:
	$reload.wait_time = rate_level_time[rate_level - 1]




func _reloaded() -> void:
	can_shoot = true
