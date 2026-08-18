extends Area2D
var speed: float = 1000.0
var damage
const BULLET_Z_INDEX: int = 15
 


 


# 
func _process(delta: float) -> void:
	
	move_local_x(speed*delta)	
# Moves the bullet a constant speed so that it doesn't slow until collision
	z_index = BULLET_Z_INDEX
# Ensure the button remains in front of the other elements

func _on_body_entered(body: Node2D) -> void:
	# When the bullet collides with other bodies

	if body.is_in_group("enemy"):
		# Check if they are the enemy
		body.get_parent().take_damage(damage)
		# If body is the enemy then make the enemy take damage of "damage".
		queue_free()
		# Delete the bullet so that it doesn't interact with more enemies


		

		
