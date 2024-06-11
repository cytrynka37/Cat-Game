extends Area2D

@export var coins = 1

@onready var game = get_parent().get_parent()

func _on_body_entered(_body):
	game.add_coins(coins)
	queue_free()
