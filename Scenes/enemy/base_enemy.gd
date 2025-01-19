extends Area2D

signal ENEMY_DIED(pos, prize_for_hit)

var vpr : Rect2
var falling_speed : float = 0
var flying_enemy : bool = true
var lifes : int = 1
var longitudinal_speed : float = 30.0
var prize_for_hit : int = 1
@export var balloon_size : Vector2 = Vector2(0.5, 0.5)

@onready var baloon = $Baloon

# Called when the node enters the scene tree for the first time.
func _ready():
	vpr = get_viewport_rect()
	falling_speed = 0
	baloon.hide()
	baloon.texture = DataManager.pick_random_balloon()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += delta*falling_speed
	if position.y < vpr.position.y-100:
		queue_free()
		
	position.x += delta * longitudinal_speed
	if position.x > vpr.end.x+100:
		queue_free()


func set_initial_data(_flying_enemy: bool, starting_lifes: int, lon_spd: float):
	global_position.x = -110.0
	flying_enemy = _flying_enemy
	lifes = starting_lifes
	prize_for_hit = 0
	if flying_enemy:
		global_position.y = randf_range(50, 360)
		prize_for_hit = prize_for_hit + 3
	else:
		global_position.y = randf_range(430, 520)
	prize_for_hit = starting_lifes * (prize_for_hit + int(lon_spd/10.0))
	longitudinal_speed = lon_spd


func fly_away():
	falling_speed = -20
	baloon.show()
	var tween = self.create_tween()
	tween.tween_property(baloon, "scale", balloon_size, 0.3)
	tween.tween_property(self, "modulate:a", 0.3, 5.0)


func _on_laser_hitted(_area):
	if falling_speed < 0.0:
		return
	lifes = lifes - 1
	if lifes > 0:
		var tween = get_tree().create_tween()
		for i in range(3):
			tween.tween_property($AnimatedSprite2D, "modulate", Color.FIREBRICK, 0.3)
			tween.tween_property($AnimatedSprite2D, "modulate", Color.WHITE, 0.3)
		return
	set_deferred("monitoring", false)
	longitudinal_speed = 0.0
	fly_away()
	ENEMY_DIED.emit(global_position, prize_for_hit)
