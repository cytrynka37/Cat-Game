extends Node2D

@export var max_health = 5
@export var score_from_enemy = 50
var health = 0
var score = 0
var paused = false

@onready var player = $Player
@onready var hud = $UI/HUD
@onready var menu = $UI/Menu
@onready var game_over_screen = $UI/GameOverScreen
@onready var win_screen = $UI/WinScreen
@onready var hearts_container = $UI/HeartsContainer

func _ready():
	health = max_health
	hud.set_score(score)
	hearts_container.set_max_hearts(max_health)
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.connect("died", _on_enemy_died)

func _on_player_took_damage(amount):
	health -= amount
	if health <= 0:
		health = 0
		show_screen(game_over_screen)
	hearts_container.update_hearts(health)

func add_lifes(amount):
	health += amount
	if health > max_health:
		health = max_health
	hearts_container.update_hearts(health)
	
func add_score(amount):
	score += amount
	hud.set_score(score)

func _on_enemy_died():
	add_score(score_from_enemy)
	
func play_pause(screen):
	paused = !paused
	get_tree().paused = paused
	hud.visible = !paused
	screen.visible = paused

func reset():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func resume(screen):
	play_pause(screen)

func quit():
	get_tree().quit()

func show_screen(screen):
	paused = true
	get_tree().paused = true
	screen.visible = true
	hud.visible = false

func _on_deathzone_body_entered(body):
	if body is Player:
		body.take_damage(health)

func _on_win_body_entered(body):
	if body is Player:
		await get_tree().create_timer(0.5).timeout
		show_screen(win_screen)
