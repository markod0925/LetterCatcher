extends Node

signal UPDATE_SCORE_LABEL

@export var bat_scene : PackedScene
@export var bee_scene : PackedScene
@export var blue_bird : PackedScene
@export var bunny : PackedScene
@export var crab : PackedScene
@export var eagle : PackedScene
@export var frog : PackedScene
@export var slug : PackedScene
@export var snail : PackedScene
@export var vulture : PackedScene

@onready var enemies : Dictionary = {
	"bat": {
		"scene": bat_scene,
		"can_fly": true,
		"lifes": 1,
		"speed": 30,
		"from_level": 1
	},
	"bee": {
		"scene": bee_scene,
		"can_fly": true,
		"lifes": 1,
		"speed": 50,
		"from_level": 1
	},
	"blue_bird": {
		"scene": blue_bird,
		"can_fly": true,
		"lifes": 2,
		"speed": 40,
		"from_level": 2
	},
	"bunny": {
		"scene": bunny,
		"can_fly": false,
		"lifes": 1,
		"speed": 20,
		"from_level": 3
	},
	"crab": {
		"scene": crab,
		"can_fly": false,
		"lifes": 2,
		"speed": 15,
		"from_level": 3
	},
	"eagle": {
		"scene": eagle,
		"can_fly": true,
		"lifes": 2,
		"speed": 60,
		"from_level": 4
	},
	"frog": {
		"scene": frog,
		"can_fly": false,
		"lifes": 1,
		"speed": 25,
		"from_level": 2
	},
	"slug": {
		"scene": slug,
		"can_fly": false,
		"lifes": 1,
		"speed": 10,
		"from_level": 1
	},
	"snail": {
		"scene": snail,
		"can_fly": false,
		"lifes": 1,
		"speed": 5,
		"from_level": 1
	},
	"vulture": {
		"scene": vulture,
		"can_fly": true,
		"lifes": 2,
		"speed": 55,
		"from_level": 3
	}
}

var available_enemies : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the available enemies for the current level
	for enemy in enemies:
		if enemies[enemy]["from_level"] <= GameManager.actual_level:
			available_enemies.append(enemy)
	$Timer.wait_time = GameManager.get_spawn_time()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var random_key = available_enemies.pick_random()
	var new_enemy = enemies[random_key]["scene"].instantiate()
	add_child(new_enemy)
	new_enemy.set_initial_data(
		enemies[random_key]["can_fly"], 
		enemies[random_key]["lifes"], 
		enemies[random_key]["speed"]
	)
	new_enemy.ENEMY_DIED.connect(_on_enemy_died)


func _on_enemy_died(pos: Vector2, inc_score: int) -> void:
	GameManager.update_score(pos, inc_score)
	UPDATE_SCORE_LABEL.emit()
