extends Control

@onready var game = get_parent().get_parent()
@onready var score = $Panel/Score
	
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		score.text = "SCORE: " + str(game.score)
		game.play_pause(self)
	
func _on_reset_pressed():
	game.reset()

func _on_resume_pressed():
	game.resume(self)

func _on_quit_pressed():
	game.quit()
