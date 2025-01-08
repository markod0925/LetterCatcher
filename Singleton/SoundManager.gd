extends Node

const LASER_SOUND = [preload("res://Assets/Sounds/lasers/sfx_wpn_laser1.wav"),
preload("res://Assets/Sounds/lasers/sfx_wpn_laser2.wav"),
preload("res://Assets/Sounds/lasers/sfx_wpn_laser4.wav"),
preload("res://Assets/Sounds/lasers/sfx_wpn_laser6.wav"),
preload("res://Assets/Sounds/lasers/sfx_wpn_laser7.wav"),
preload("res://Assets/Sounds/lasers/sfx_wpn_laser8.wav"),
preload("res://Assets/Sounds/lasers/sfx_wpn_laser9.wav"),
preload("res://Assets/Sounds/lasers/sfx_wpn_laser10.wav")]

const GAME_SOUND = [
preload("res://Assets/Sounds/game/Orchestral Loop #1.ogg"),
preload("res://Assets/Sounds/game/Orchestral Loop #2.ogg"),
preload("res://Assets/Sounds/game/Orchestral Loop #3.ogg"),
preload("res://Assets/Sounds/game/Orchestral Loop #4.ogg"),
preload("res://Assets/Sounds/game/Orchestral Loop #5.ogg"),
preload("res://Assets/Sounds/game/Orchestral Loop #6.ogg"),
preload("res://Assets/Sounds/game/Orchestral Loop #7.ogg"),
preload("res://Assets/Sounds/game/Orchestral Loop #8.ogg"),
preload("res://Assets/Sounds/game/Orchestral Loop #9.ogg"),
preload("res://Assets/Sounds/game/Orchestral Loop #10.ogg")
]

const START_SOUND = [
preload("res://Assets/Sounds/start_screen/Lyric Fantasy Theme #1.ogg"),
preload("res://Assets/Sounds/start_screen/Lyric Fantasy Theme #2.ogg"),
preload("res://Assets/Sounds/start_screen/Lyric Fantasy Theme #3.ogg"),
preload("res://Assets/Sounds/start_screen/Lyric Fantasy Theme #4.ogg")
]

const WIN_SOUND = [
preload("res://Assets/Sounds/win_music.ogg")
]

const LOSE_SOUND = [
preload("res://Assets/Sounds/lose_music.ogg")
]

const LETTER_BURNED_SOUND = [
preload("res://Assets/Sounds/explosions/sfx_exp_medium1.wav"),
preload("res://Assets/Sounds/explosions/sfx_exp_medium2.wav"),
preload("res://Assets/Sounds/explosions/sfx_exp_medium5.wav"),
preload("res://Assets/Sounds/explosions/sfx_exp_medium6.wav"),
preload("res://Assets/Sounds/explosions/sfx_exp_medium13.wav")
]

func play_laser_random(audio: AudioStreamPlayer):
	audio.stream = LASER_SOUND.pick_random()
	audio.play()

func play_letter_burned_random(audio: AudioStreamPlayer):
	audio.stream = LETTER_BURNED_SOUND.pick_random()
	audio.play()

func play_music_random(audio: AudioStreamPlayer, scene: String):
	match scene:
		"START":
			audio.stream = START_SOUND.pick_random()
		"GAME":
			audio.stream = GAME_SOUND.pick_random()
		"WIN":
			audio.stream = WIN_SOUND.pick_random()
		"LOSE":
			audio.stream = LOSE_SOUND.pick_random()
	audio.play()
