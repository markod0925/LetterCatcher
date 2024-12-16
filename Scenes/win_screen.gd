extends Control

@onready var _title = $VBoxContainer/Title
@onready var _story = $VBoxContainer/StoryText
@onready var _score_number = $VBoxContainer/HBoxContainer/ScoreNumber


func _set_title_and_story(title: String, story: String) -> void:
	_title.text = title
	_story.text = story
	_score_number.text = str(GameManager.PlayerScore).pad_zeros(5)
