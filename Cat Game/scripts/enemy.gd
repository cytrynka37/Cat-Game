extends CharacterBody2D
class_name Enemy

signal died

@export var gravity = 400
@export var max_health = 3
var health = 0
var direction = 1

@onready var player = get_parent().get_parent().get_node("Player")
@onready var sprite = $AnimatedSprite2D

func _ready():
	health = max_health

func take_damage(amount):
	health -= amount
	get_node("HealthBar").update_health_bar(health, max_health)
	if (health <= 0):
		die()

func die():
	emit_signal("died")
	queue_free()
