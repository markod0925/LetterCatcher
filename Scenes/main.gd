extends Node2D

@export var letter_scene : PackedScene
@export var expl_scene : PackedScene
@export var letter_timer : Timer
@export var letter_container : Node2D
@export var balloon_container : Node
@export var sound_container : Node
@export var score_label : Label
@export var laser_scene : PackedScene
@export var level_label : Label
@onready var game_over_screen = $Screens/GameOverScreen
@onready var win_screen = $Screens/WinScreen
@onready var pause_screen = $Screens/PauseScreen
@onready var main_bg = $Parallax2D/MainBg
@onready var book = $Book

const MARGIN : float = 55.0

var vpr : Vector2
var _story : String
var _title : String
var letter_counter : int = 0
var _last_letter_emitted : bool = false
var letters_burned : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	vpr = get_viewport_rect().end
	# Select a random story
	var _story_dict = GameManager.get_story()
	_title = _story_dict["title"]
	_story = _story_dict["text"]
	
	score_label.text = str(GameManager.PlayerScore).pad_zeros(5)
	game_over_screen.hide()
	win_screen.hide()
	
	var message : String
	message = tr("KEY_MAIN_LEVEL")
	message += ": %s/%s" % [str(GameManager.actual_level), str(GameManager.difficulty_dict[GameManager.actual_difficulty]["boss_level"])]
	level_label.text = message
	
	letter_timer.wait_time = GameManager.get_wait_time()
	var tween : Tween = create_tween()
	tween.tween_property(book, "modulate:a", 1.0, 2.5)
	
	_set_smooth_dissolve(0.0)
	$Screens/ColorBlindCorrection.material.set_shader_parameter("mode", GameManager.color_blind_mode)

	SoundManager.play_music_random($BGMusic, "GAME")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if _title == GameManager.ERROR_CODE:
		GameManager.load_start_screen()
		return
	
	if game_over_screen.visible or win_screen.visible:
		return
	if _last_letter_emitted and letter_container.get_child_count() == 0:
		await get_tree().create_timer(0.2).timeout
		game_win()
		return
	

func _input(event: InputEvent):
	# Restart the game if the player press "Space" and the game is over
	if event is InputEventKey and event.is_pressed() and not event.is_echo() and (game_over_screen.visible or win_screen.visible):
		if event.keycode == KEY_SPACE:
			if win_screen.visible:
				GameManager.load_new_level()
			else:
				GameManager.load_start_screen()
		return

	if event is InputEventKey and event.is_pressed() and not event.is_echo() and event.keycode == KEY_ESCAPE:
		if pause_screen.visible:
			resume_game()
		else:
			pause_game()
	#print(event)
	#print(letters_burned)

	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var key_unicode = event.keycode
		if (key_unicode >= 65 and key_unicode <= 90) or (key_unicode >= 97 and key_unicode <= 122):
			var letter = char(key_unicode).to_upper()
			for ltime in letter_container.get_children():
				if ltime.text.to_upper() == letter:
					make_explosion_and_shoot(ltime.position + Vector2(32, 20))
					GameManager.update_score(ltime.position + Vector2(32, 20), 1)
					ltime.fly_away()
					# Move the letter to BalloonContainer
					letter_container.remove_child(ltime)
					balloon_container.add_child(ltime)					
					_on_update_score_label()
					letter_timer.wait_time = GameManager.get_wait_time()
					#print("Wait time: %s" % str(letter_timer.wait_time))
					return
			#Remove points in HARD mode when wrong key is pressed
			if GameManager.actual_difficulty == GameManager.Difficulty.HARD:
				GameManager.update_score(Vector2(576, 512), -GameManager.actual_level)
				_on_update_score_label()


func _on_letter_time_timeout():
	if _last_letter_emitted:
		return
	var new_letter = letter_scene.instantiate()
	var letter_data : Dictionary = _get_legit_char_from_story()
	if letter_data["letter"] == "END":
		new_letter.queue_free()
		letter_timer.stop()
		_last_letter_emitted = true
		return
	letter_container.add_child(new_letter)
	new_letter.set_initial_data(letter_data, MARGIN + (2.0 - float(GameManager.actual_difficulty)) * 100.0)
	new_letter.BURN_LETTER.connect(_on_letter_burned)


func game_win() -> void:
	letter_timer.stop()
	remove_burned_letters_from_story()
	win_screen._set_title_and_story(_title, _story)
	win_screen.show()
	SoundManager.play_music_random($BGMusic, "WIN")


func game_over() -> void:
	letter_timer.stop()
	for ltime in letter_container.get_children():
		ltime.set_process(false)
		ltime.queue_free()
	set_process(false)
	game_over_screen.set_highscore()
	game_over_screen.show()
	GameManager.PlayerScore = 0
	GameManager.actual_level = 1
	DataManager.save_game_data()
	SoundManager.play_music_random($BGMusic, "LOSE")


func make_explosion_and_shoot(pos: Vector2) -> void:
	var new_laser = laser_scene.instantiate()
	add_child(new_laser)
	new_laser.shoot(Vector2(576, 568), pos)
	var new_explo = expl_scene.instantiate()
	new_explo.global_position = pos
	add_child(new_explo)
	for sound in sound_container.get_children():
		if not sound.is_playing():
			SoundManager.play_laser_random(sound)
			break


func _get_legit_char_from_story() -> Dictionary:
	var story_chars = _story.to_upper()
	var special_chars = {
		"Ò": "O", "È": "E", "À": "A", "É": "E", "Ì": "I", "Ù": "U",
		"Á": "A", "Í": "I", "Ó": "O", "Ú": "U", "Ñ": "N",
		"Ä": "A", "Ö": "O", "Ü": "U", "ß": "SS",  # German special characters
		"Â": "A", "Ê": "E", "Î": "I", "Ô": "O", "Û": "U", "Ç": "C"  # French special characters
	}
	for i in range(letter_counter, story_chars.length()):
		var _char = story_chars[i]
		if _char in special_chars:
			_char = special_chars[_char]
		if (_char >= "A" and _char <= "Z"):
			letter_counter = i + 1
			return {"letter": _char, "index": i}
	return {"letter": "END", "index": story_chars.length()}


func _on_letter_burned(letter_pos:int) -> void:
	if letter_pos in letters_burned:
		return
	letters_burned.append(letter_pos)
	var dissolve_start : float = main_bg.material.get_shader_parameter("dissolve_pct")
	if dissolve_start >= 1.0:
		await get_tree().create_timer(0.2).timeout
		game_over()
		return
	var dissolve_inc : float = GameManager.get_failure_rate()/(_story.length())
	var tween : Tween = get_tree().create_tween()
	var dissolve_time : float = clamp(GameManager.get_wait_time() - 0.1, 0.0, 2.0)
	var dissolve_final : float = clamp(dissolve_start+dissolve_inc, 0.0, 1.0)
	tween.tween_method(_set_smooth_dissolve, dissolve_start, dissolve_final, dissolve_time) # it must be less than the Timer's wait_time
	for sound in sound_container.get_children():
		if not sound.is_playing():
			SoundManager.play_letter_burned_random(sound)
			break
	#print(main_bg.material.get_shader_parameter("dissolve_pct"))


func remove_burned_letters_from_story() -> void:
	var new_story = ""
	for i in range(_story.length()):
		if i not in letters_burned:
			new_story += _story[i]
	_story = new_story
	letters_burned = []


func _set_smooth_dissolve(value: float) -> void:
	main_bg.material.set_shader_parameter("dissolve_pct", value)
 

func pause_game() -> void:
	letter_timer.stop()
	for ltime : Label in letter_container.get_children():
		ltime.set_process(false)
		ltime.hide()
	pause_screen.show()


func resume_game() -> void:
	letter_timer.start()
	for ltime : Label in letter_container.get_children():
		ltime.set_process(true)
		ltime.show()
	pause_screen.hide()


func _on_update_score_label():
	score_label.text = str(GameManager.PlayerScore).pad_zeros(5)
