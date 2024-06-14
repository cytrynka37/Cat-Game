extends CharacterBody2D
class_name Enemy

signal died

@export var gravity = 400
@export var max_health = 3
var health = 0
var direction = 0

@onready var player = get_parent().get_parent().get_node("Player")
@onready var sprite = $Sprite2D

func _ready():
	health = max_health

func _physics_process(_delta):
	var diff = player.global_position.x - global_position.x
	if (diff > 0):
		direction = 1
		sprite.flip_h = false
	else:
		direction = -1
		sprite.flip_h = true

func take_damage(amount):
	health -= amount
	get_node("HealthBar").update_health_bar(health, max_health)
	if (health <= 0):
		die()

func die():
	emit_signal("died")
	queue_free()
