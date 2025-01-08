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


func play_laser_random(audio: AudioStreamPlayer):
	audio.stream = LASER_SOUND.pick_random()
	audio.play()


func play_music_random(audio: AudioStreamPlayer, scene: String):
	match scene:
		"START":
			audio.stream = START_SOUND.pick_random()
		"GAME":
			audio.stream = GAME_SOUND.pick_random()
	audio.play()
