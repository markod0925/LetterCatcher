extends Node2D


func setup(pos : Vector2, info: String) -> void:
	var animation_player = $AnimationPlayer
	var info_label = $InfoLabel
	info_label.text = str(info)
	animation_player.play("popup")
	global_position = pos
