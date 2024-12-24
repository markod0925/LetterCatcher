extends Node

var PlayerScore : int = 0
var actual_level : int = 1
var actual_difficulty : Difficulty = Difficulty.EASY
var list_balloon_files : Array
var POPUP_SCENE : PackedScene = preload("res://Scenes/popup/popup.tscn")
var local_lang = "it"

enum Difficulty {EASY, MEDIUM, HARD}

# Definisci per ogni livello di difficoltà il tempo di attesa tra un lettera e l'altra, e la velocità di movimento delle lettere
var difficulty_dict = {
	Difficulty.EASY: {"wait_time": 2.0, "letter_speed": 10.0, "failure_rate": 1.0/0.25, "spawn_enemies_rate": 5.0},
	Difficulty.MEDIUM: {"wait_time": 1.0, "letter_speed": 20.0, "failure_rate": 1.0/0.15, "spawn_enemies_rate": 2.5},
	Difficulty.HARD: {"wait_time": 0.5, "letter_speed": 40.0, "failure_rate": 1.0/0.02, "spawn_enemies_rate": 1.5}
}

# Stories List
var stories_dict = {"Cavalieri": "Il giovane cavaliere, tremante di paura, si avvicinò al drago addormentato. Il drago era enorme, con squame luccicanti e artigli affilati. Il cavaliere alzò la spada, ma il drago si svegliò e ruggì. Il cavaliere fuggì via, terrorizzato.", 
"Draghi": "Il drago sputò fuoco, ma il cavaliere riuscì a schivare. Il cavaliere colpì il drago con la sua spada, e il drago cadde a terra. Il cavaliere si avvicinò al drago e lo accarezzò. Il drago si addormentò, e il cavaliere sorrise.", 
"Spettacolo teatrale": "La bambina si alzò in piedi e si inchinò. Il pubblico applaudì, e la bambina sorrise. Era felice di aver fatto una buona performance.",
"Villaggio": "Il villaggio era tranquillo, con le case di legno e i tetti di paglia. I bambini giocavano per strada, e le donne facevano la spesa. Gli uomini lavoravano nei campi, e le donne cucinavano il pranzo. Il villaggio era felice e sereno.",
"Castello": "Il castello era grande e maestoso, con le torri alte e le mura spesse. Il re e la regina vivevano nel castello, con i loro figli e i loro servitori. Il castello era pieno di vita e di allegria.",
"Regina": "La regina era bella e gentile, con i capelli biondi e gli occhi azzurri. La regina amava i fiori e gli animali, e passava le giornate a passeggiare nei giardini del castello. La regina era amata da tutti, per la sua bontà e la sua generosità.",
"Re": "Il re era forte e coraggioso, con la barba nera e gli occhi scuri. Il re amava la caccia e il combattimento, e passava le giornate a cavallo per la campagna. Il re era rispettato da tutti, per la sua saggezza e la sua giustizia.",
"Dinosauri": "Il piccolo dinosauro si sedette sotto un albero e piangeva. I suoi amici cercarono di consolarlo, ma niente funzionava. Il piccolo dinosauro era troppo triste.",
"Robot": "Il robot si alzò in piedi e guardò il cielo. Il cielo era pieno di stelle, e il robot sorrise. Aveva speranza per il futuro.",
"Fate": "La fata volò attraverso la foresta, spargendo polvere di fata. I fiori sbocciarono, e gli animali cantarono. La fata era felice di aver portato gioia nel mondo.",
"Natale": "Il bambino guardò l'albero di Natale, pieno di luci e decorazioni. I suoi occhi erano pieni di meraviglia. Non poteva credere che fosse Natale.", 
"Cane": "Il cane abbaiò e corse verso il padrone. Il padrone lo accarezzò e gli diede un biscotto. Il cane era felice e scodinzolò.",}


# Functions list

func add_child_deffered(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)


func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deffered", child_to_add)
	

func load_main_scene() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func load_start_screen() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")


func get_wait_time() -> float:
	return clamp(difficulty_dict[actual_difficulty]["wait_time"], 0.21, 2.0)


func get_spawn_time() -> float:
	return clamp(difficulty_dict[actual_difficulty]["spawn_enemies_rate"], 1.0, 10.0)


func get_letter_speed() -> float:
	return difficulty_dict[actual_difficulty]["letter_speed"]


func get_failure_rate() -> float:
	return difficulty_dict[actual_difficulty]["failure_rate"]


func start_new_game() -> void:
	PlayerScore = 0
	actual_level = 1
	list_balloon_files = list_balloons()
	load_main_scene()


func update_score(pos: Vector2, value: int) -> void:
	create_info_popup_scene(pos, "+%s" %value)
	PlayerScore = PlayerScore + value
	if PlayerScore >= DataManager.high_score[str(actual_difficulty)]:
		DataManager.high_score[str(actual_difficulty)] = PlayerScore


func create_info_popup_scene(pos: Vector2, info: String) -> void:
	var new_popup = POPUP_SCENE.instantiate()
	new_popup.setup(pos, info)
	call_add_child(new_popup)


func list_balloons() -> Array:
	var balloons = []
	var dir = DirAccess.open("res://Assets/Balloons")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".png"):
				balloons.append(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("An error occurred when trying to access the path.")
	return balloons
