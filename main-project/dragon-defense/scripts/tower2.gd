extends CharacterBody2D
@export var pivot: Node2D
@export var bullet_scene: PackedScene
@export var right_bullet_spawn: Marker2D
@export var left_bullet_spawn: Marker2D
var can_shoot = true
var target_enemy
var enemy_number
var possible_target
var target_enemy_no = 1000
var targetable_enemies = {}
var body_detected
var level = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		
		target_enemy_no = 1000
		for enemy_number in targetable_enemies:
			if enemy_number < target_enemy_no:
				target_enemy_no = enemy_number
		if target_enemy_no != 1000:
			target_enemy = targetable_enemies[target_enemy_no]
			var target_angle = global_position.angle_to_point(target_enemy.global_position)
			rotation = rotate_toward(rotation, target_angle, 3.0 * delta)
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
		bullet.global_position = left_bullet_spawn.global_position
		bullet.rotation = rotation
		add_sibling(bullet)
		can_shoot = false
		$reload.start()
		







func _reloaded() -> void:
	can_shoot = true
