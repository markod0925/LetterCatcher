extends Control

@onready var _title = $VBoxContainer/Title
@onready var _story = $VBoxContainer/StoryText
@onready var _score_number = $VBoxContainer/HBoxContainer/ScoreNumber

func _ready():
	$UpMsg.text = tr("KEY_WIN_SCREEN_UPMSG").to_upper()
	$VBoxContainer/HBoxContainer/ScoreLabel.text = tr("KEY_WIN_SCREEN_SCORE_LABEL").to_upper()
	$SpaceMsg.text = tr("KEY_WIN_SCREEN_SPACE_MSG").to_upper()


func _set_title_and_story(title: String, story: String) -> void:
	_title.text = title
	_story.text = story
	_score_number.text = str(GameManager.PlayerScore).pad_zeros(5)
	if GameManager.Boss_activated:
		$UpMsg.text = tr("KEY_WIN_SCREEN_UPMSG_BOSS").to_upper()
		$SpaceMsg.text = tr("KEY_SPACE_MSG_RESTART").to_upper()
	else:
		$UpMsg.text = tr("KEY_WIN_SCREEN_UPMSG").to_upper()
		$SpaceMsg.text = tr("KEY_WIN_SCREEN_SPACE_MSG").to_upper()
