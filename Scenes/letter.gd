extends Label

signal BURN_LETTER(letter_pos)

var falling_speed : float = 10
var story_position : int
var vpr : Rect2
var _lower_case_level : bool = false

@export var burning_scene : PackedScene
@onready var baloon = $Baloon

# Called when the node enters the scene tree for the first time.
func _ready():
	vpr = get_viewport_rect()
	# Pick a random preloaded texture from the list
	baloon.hide()
	baloon.texture = DataManager.pick_random_balloon()
	_lower_case_level = GameManager.actual_level%2 == 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += delta*falling_speed
	
	if position.y > vpr.end.y-36:
		BURN_LETTER.emit(story_position)
		# Play an animation of burning and then queue_free()
		var burning = burning_scene.instantiate()
		burning.position = position
		get_tree().get_root().add_child(burning)
		queue_free()

	if position.y < get_viewport_rect().position.y-100:
		queue_free()


# Called when the letter is created
func set_initial_data(letter_data: Dictionary, screen_margin: float):
	if _lower_case_level:
		letter_data["letter"] = letter_data["letter"].to_lower()
	
	text = letter_data["letter"]
	story_position = letter_data["index"]
	global_position.x = randf_range(vpr.position.x + screen_margin, vpr.end.x-screen_margin)
	global_position.y = vpr.position.y-50.0
	falling_speed = GameManager.get_letter_speed() + GameManager.actual_level * 2
	#print("Falling speed: %s" % falling_speed)


func fly_away():
	falling_speed = -20
	baloon.show()
	var tween = self.create_tween()
	tween.tween_property(baloon, "scale", Vector2(0.4, 0.4), 0.3)
	tween.tween_property(self, "modulate:a", 0.3, 5.0)
