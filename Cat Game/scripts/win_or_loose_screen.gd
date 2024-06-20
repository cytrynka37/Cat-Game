extends Control

@onready var game = get_parent().get_parent()
@onready var score = $Panel/Score

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta):
	score.text = "SCORE: " + str(game.score)
	
func _on_reset_pressed():
	game.reset()

func _on_quit_pressed():
	game.quit()
