extends Line2D

@onready var timer : Timer = $Timer
@onready var line_shape : CollisionShape2D = $Hitbox/LineShape

# Called every frame. 'delta' is the elapsed time since the previous frame.
func shoot(start_pos: Vector2, end_pos: Vector2) -> void:
	# Create a new line
	add_point(start_pos)
	add_point(end_pos)
	var line : SegmentShape2D = SegmentShape2D.new()
	line.a = start_pos
	line.b = end_pos
	line_shape.shape = line
	timer.start()

func _on_timer_timeout():
	queue_free()
