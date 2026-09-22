extends Area2D
var speed: float = 1000.0
var damage
const BULLET_Z_INDEX: int = 15
 


 


func _process(delta: float) -> void:
# Moves the bullet a constant speed so that it doesn't slow until collision
	move_local_x(speed*delta)	
# Ensure the button remains in front of the other elements
	z_index = BULLET_Z_INDEX

# When the bullet collides with other bodies
func _on_body_entered(body: Node2D) -> void:
# Check if they are the enemy
	if body.is_in_group("enemy"):
		# If body is the enemy then make the enemy take damage of "damage".
		body.get_parent().take_damage(damage)
		# Delete the bullet so that it doesn't interact with more enemies
		queue_free()
