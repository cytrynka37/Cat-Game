extends Area2D

@export var score = 10

@onready var game = get_parent().get_parent()

func _on_body_entered(_body):
	game.add_score(score)
	queue_free()
