extends Control

@onready var fill_max = $ColorRect.size.x 
var fill_amount = 0

func update_health_bar(health, max_health):
	fill_amount = float(health) / max_health * fill_max
	$ColorRect.size.x = fill_amount
