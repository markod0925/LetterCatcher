extends Control

@onready var _title = $VBoxContainer/Title
@onready var _story = $VBoxContainer/StoryText
@onready var _score_number = $VBoxContainer/HBoxContainer/ScoreNumber

func _ready():
	$UpMsg.text = tr("KEY_WIN_SCREEN_UPMSG")
	$VBoxContainer/HBoxContainer/ScoreLabel.text = tr("KEY_WIN_SCREEN_SCORE_LABEL")
	$SpaceMsg.text = tr("KEY_WIN_SCREEN_SPACE_MSG")


func _set_title_and_story(title: String, story: String) -> void:
	_title.text = title
	_story.text = story
	_score_number.text = str(GameManager.PlayerScore).pad_zeros(5)
