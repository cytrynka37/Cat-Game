extends Node2D

@export var max_health = 5
@export var coins_from_enemy = 3
var health = 0
var coins = 0
var paused = false

@onready var player = $Player
@onready var hud = $UI/HUD
@onready var menu = $UI/Menu
@onready var game_over_screen = $UI/GameOverScreen

func _ready():
	health = max_health
	hud.set_life(health)
	hud.set_coins(coins)
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.connect("died", _on_enemy_died)

func _on_player_took_damage(amount):
	health -= amount
	hud.set_life(health)
	if (health <= 0):
		health = 0
		play_pause(game_over_screen)
		
func add_lifes(amount):
	health += amount
	if health > max_health:
		health = max_health
	hud.set_life(health)
	
func add_coins(amount):
	coins += amount
	hud.set_coins(coins)

func _on_enemy_died():
	add_coins(coins_from_enemy)
	
func play_pause(screen):
	paused = !paused
	get_tree().paused = paused
	screen.visible = paused

func reset(screen):
	play_pause(screen)
	get_tree().reload_current_scene()
	
func resume(screen):
	play_pause(screen)

func quit():
	get_tree().quit()
