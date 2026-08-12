extends Area2D
var speed: float = 1000.0
const BULLET_Z_INDEX: int = 15



 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_local_x(speed*delta)
	z_index = BULLET_Z_INDEX

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.get_parent().take_damage()
		queue_free()


		

		
