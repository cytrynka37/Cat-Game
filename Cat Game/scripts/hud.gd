extends Control

@onready var coins = $Coins
@onready var life = $Life

func set_coins(new_coins):
	coins.text = "coins: " + str(new_coins)
	
func set_life(new_life):
	life.text = "life: " + str(new_life)
