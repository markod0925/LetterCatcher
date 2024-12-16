extends Node2D

@export var letter_scene : PackedScene
@export var expl_scene : PackedScene
@export var letter_timer : Timer
@export var letter_container : Node
@export var balloon_container : Node
@export var score_label : Label
@export var laser_scene : PackedScene
@export var level_label : Label
@onready var game_over_screen = $Screens/GameOverScreen
@onready var win_screen = $Screens/WinScreen

const MARGIN : float = 55.0

var vpr : Vector2
var _story : String
var _title : String
var letter_counter : int = 0
var _last_letter_emitted : bool = false
var _lower_case_level : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	vpr = get_viewport_rect().end
	# Select a random story
	var _rand_number = randi_range(0, GameManager.stories_dict.size()-1)
	_title = GameManager.stories_dict.keys()[_rand_number]
	_story = GameManager.stories_dict[_title]
	
	score_label.text = str(GameManager.PlayerScore).pad_zeros(5)
	game_over_screen.hide()
	win_screen.hide()
	
	_lower_case_level = GameManager.actual_level%2 == 0
	level_label.text = "Level: %s" % str(GameManager.actual_level)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game_over_screen.visible or win_screen.visible:
		return
	if _last_letter_emitted and letter_container.get_child_count() == 0:
		game_win()
		return
	

func _input(event: InputEvent):
	# Restart the game if the player press "Space" and the game is over
	if event is InputEventKey and event.is_pressed() and not event.is_echo() and (game_over_screen.visible or win_screen.visible):
		if event.keycode == KEY_SPACE:
			if win_screen.visible:
				get_tree().reload_current_scene()
			else:
				GameManager.load_start_screen()
			return

	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var key_unicode = event.keycode
		if (key_unicode >= 65 and key_unicode <= 90) or (key_unicode >= 97 and key_unicode <= 122):
			var letter = char(key_unicode).to_upper()
			for ltime in letter_container.get_children():
				if ltime.text.to_upper() == letter:
					make_explosion(ltime.position + Vector2(32, 20))
					ltime.fly_away()
					# Move the letter to BalloonContainer
					letter_container.remove_child(ltime)
					balloon_container.add_child(ltime)
					GameManager.PlayerScore = GameManager.PlayerScore + 1
					score_label.text = str(GameManager.PlayerScore).pad_zeros(5)
					letter_timer.wait_time = clamp(GameManager.get_wait_time(), 0.05, 2.0)
					break


func _on_letter_time_timeout():
	if _last_letter_emitted:
		return
	var new_letter = letter_scene.instantiate()
	var _charTmp : String = _get_legit_char_from_story()
	if _charTmp == "END":
		new_letter.queue_free()
		letter_timer.stop()
		_last_letter_emitted = true
		return
	# Insert here the logic to switch to lower case instead of upper case
	if _lower_case_level:
		_charTmp = _charTmp.to_lower()
	new_letter.text = _charTmp
	new_letter.position.x = randf_range(MARGIN, vpr.x-MARGIN)
	new_letter.position.y = -MARGIN
	new_letter.GAME_OVER.connect(game_over)
	new_letter.SPEED = GameManager.get_letter_speed() + GameManager.actual_level * 2
	letter_container.add_child(new_letter)


func game_win() -> void:
	letter_timer.stop()
	win_screen._set_title_and_story(_title, _story)
	win_screen.show()
	GameManager.actual_level = GameManager.actual_level + 1


func game_over() -> void:
	letter_timer.stop()
	for ltime in letter_container.get_children():
		ltime.set_process(false)
	set_process(false)
	game_over_screen.set_highscore()
	game_over_screen.show()
	GameManager.PlayerScore = 0
	GameManager.actual_level = 1


func make_explosion(pos: Vector2) -> void:
	var new_laser = laser_scene.instantiate()
	add_child(new_laser)
	new_laser.shoot(Vector2(576, 648), pos)
	var new_explo = expl_scene.instantiate()
	new_explo.global_position = pos
	add_child(new_explo)


func _get_legit_char_from_story() -> String:
	var story_chars = _story.to_upper()
	for i in range(letter_counter, story_chars.length()):
		if (story_chars[i] >= "A" and story_chars[i] <= "Z"):
			letter_counter = i + 1 
			return story_chars[i]
	return "END"
