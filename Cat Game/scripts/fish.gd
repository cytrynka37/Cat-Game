extends Area2D

@export var lifes = 1

@onready var game = get_parent().get_parent()

func _on_body_entered(_body):
	game.add_lifes(lifes)
	queue_free()
