extends Line2D

@onready var timer : Timer = $Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func shoot(start_pos: Vector2, end_pos: Vector2) -> void:
	# Create a new line
	add_point(start_pos)
	add_point(end_pos)
	timer.start()

func _on_timer_timeout():
	queue_free()
