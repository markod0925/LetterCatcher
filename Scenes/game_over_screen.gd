extends Control

@onready var highscore = $Highscore

func _ready():
	var message : String
	message = tr("KEY_SCORE_LABEL")
	message += ": %s" %str(GameManager.PlayerScore).pad_zeros(5)
	$Highscore.text = message
	$SpaceMsg.text = tr("KEY_SPACE_MSG_RESTART").to_upper()

func set_highscore() -> void:
	var message : String
	message = tr("KEY_SCORE_LABEL")
	message += ": %s" %str(GameManager.PlayerScore).pad_zeros(5)
	$Highscore.text = message
