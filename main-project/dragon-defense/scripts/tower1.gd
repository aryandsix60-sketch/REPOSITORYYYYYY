extends CharacterBody2D
@export var pivot: Node2D
@export var bullet_scene: PackedScene
@export var right_bullet_spawn: Marker2D
@export var left_bullet_spawn: Marker2D
@export var tower_menu_scene: PackedScene
@export var tower_menu_spawn: Marker2D
@export var tower_menu_backup_spawn: Marker2D


var left_can_shoot = true
var right_can_shoot = true
var target_enemy
var enemy_number
var possible_target
var target_enemy_no = 1000
var targetable_enemies = {}
var body_detected
var level = 1
var damage = float(2.0)
var damage_level = 1
var range_level = 1
var rate_level = 1




# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	rotation = deg_to_rad(-90)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		tower_menu_spawn.global_position = global_position + Vector2(0,-300)
		
		target_enemy_no = 1000
		for enemy_number in targetable_enemies:
			if enemy_number < target_enemy_no:
				target_enemy_no = enemy_number
		if target_enemy_no != 1000:
			target_enemy = targetable_enemies[target_enemy_no]
			var target_angle = global_position.angle_to_point(target_enemy.global_position)
			rotation = rotate_toward(rotation, target_angle, 3.0 * delta)
			if right_can_shoot:
				right_shoot()
			if left_can_shoot:
				left_shoot()
				
		
		


func _enemy_in_range(body: Node2D) -> void:
	possible_target = body.get_parent()
	if possible_target.is_in_group("enemy"):
		targetable_enemies[possible_target.enemy_no] = possible_target
		
			

func _enemy_out_range(body: Node2D) -> void:
	body_detected = body.get_parent()
	if body_detected.is_in_group("enemy"):
		targetable_enemies.erase(body_detected.enemy_no)


	
func right_shoot() -> void:
		var bullet = bullet_scene.instantiate()
		bullet.damage = damage
		bullet.global_position = right_bullet_spawn.global_position
		bullet.rotation = rotation
		add_sibling(bullet)
		right_can_shoot = false
		$right_reload.start()
		
func left_shoot() -> void:
		var bullet = bullet_scene.instantiate()
		bullet.damage = damage
		bullet.global_position = left_bullet_spawn.global_position
		bullet.rotation = rotation
		add_sibling(bullet)
		left_can_shoot = false
		$left_reload.start()
		






func _right_reloaded() -> void:
	right_can_shoot = true


func left_reloaded() -> void:
	left_can_shoot = true


func _open_tower_menu() -> void:
	if not global.tower_menu_active:
		var tower_menu = tower_menu_scene.instantiate()
		tower_menu.damage_level = damage_level
		tower_menu.range_level = range_level
		tower_menu.rate_level = rate_level
		
		add_child(tower_menu)
		

		tower_menu.top_level = true
		tower_menu.global_position = tower_menu_spawn.global_position
		global.tower_menu_active = true
	
