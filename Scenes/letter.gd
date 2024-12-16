extends Label

signal GAME_OVER

var SPEED : int = 50
var vpr : Vector2
@onready var baloon = $Baloon

# Called when the node enters the scene tree for the first time.
func _ready():
	vpr = get_viewport_rect().end
	# Pick a random .png file from the list
	baloon.hide()
	var balloon_list = list_balloons()
	var random_balloon = balloon_list[randi_range(0, balloon_list.size()-1)]
	baloon.texture = load("res://Assets/Balloons/%s" % random_balloon)
	_set_shader_param(0.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += delta*SPEED
	
	if position.y > vpr.y-36:
		GAME_OVER.emit()
		# Make a tween that modify a shader property adn then call queue_free() as method
		var tween = get_tree().create_tween()
		tween.tween_method(_set_shader_param, 0.0, 1.0, 2.0)
		tween.tween_callback(self.queue_free)

	if position.y < get_viewport_rect().position.y-100:
		queue_free()


func fly_away():
	SPEED = -20
	baloon.show()

func list_balloons():
	var balloons = []
	var dir = DirAccess.open("res://Assets/Balloons")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".png"):
				balloons.append(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")
	return balloons


func _set_shader_param(value: float) -> void:
	self.material.set_shader_parameter("dissolve_pct", value)
