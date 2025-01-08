extends Node

signal UPDATE_SCORE_LABEL

# Exported variables for different enemy scenes
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
@export var boss : PackedScene

# Dictionary containing enemy data
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
		"speed": 55,
		"from_level": 2
	},
	"blue_bird": {
		"scene": blue_bird,
		"can_fly": true,
		"lifes": 2,
		"speed": 45,
		"from_level": 3
	},
	"bunny": {
		"scene": bunny,
		"can_fly": false,
		"lifes": 1,
		"speed": 30,
		"from_level": 4
	},
	"crab": {
		"scene": crab,
		"can_fly": false,
		"lifes": 3,
		"speed": 25,
		"from_level": 3
	},
	"eagle": {
		"scene": eagle,
		"can_fly": true,
		"lifes": 2,
		"speed": 80,
		"from_level": 5
	},
	"frog": {
		"scene": frog,
		"can_fly": false,
		"lifes": 2,
		"speed": 30,
		"from_level": 3
	},
	"slug": {
		"scene": slug,
		"can_fly": false,
		"lifes": 1,
		"speed": 25,
		"from_level": 1
	},
	"snail": {
		"scene": snail,
		"can_fly": false,
		"lifes": 1,
		"speed": 20,
		"from_level": 2
	},
	"vulture": {
		"scene": vulture,
		"can_fly": true,
		"lifes": 2,
		"speed": 60,
		"from_level": 3
	},
	"boss": {
		"scene": boss,
		"can_fly": false,
		"lifes": 50,
		"speed": 20,
		"from_level": 100
	}
}

# Array to store available enemies for the current level
var available_enemies : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the available enemies for the current level
	for enemy in enemies:
		if enemies[enemy]["from_level"] <= GameManager.actual_level:
			available_enemies.append(enemy)
	$Timer.wait_time = GameManager.get_spawn_time()
	if GameManager.Boss_activated:
		spawn_an_enemy("boss")

# Called when the timer times out to spawn a new enemy
func _on_timer_timeout():
	spawn_an_enemy(pick_an_enemy())

# Function to pick a random enemy from the available enemies
func pick_an_enemy() -> String:
	return available_enemies.pick_random()

# Function to spawn an enemy
func spawn_an_enemy(_enemy: String) -> void:
	var new_enemy = enemies[_enemy]["scene"].instantiate()
	add_child(new_enemy)
	new_enemy.set_initial_data(
		enemies[_enemy]["can_fly"], 
		enemies[_enemy]["lifes"], 
		enemies[_enemy]["speed"]
	)
	new_enemy.ENEMY_DIED.connect(_on_enemy_died)
	
# Function to handle the event when an enemy dies
func _on_enemy_died(pos: Vector2, inc_score: int) -> void:
	GameManager.update_score(pos, inc_score)
	UPDATE_SCORE_LABEL.emit()
