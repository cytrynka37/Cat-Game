extends Control

@onready var game = get_parent().get_parent()

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _on_reset_pressed():
	game.reset(self)

func _on_quit_pressed():
	game.quit()
