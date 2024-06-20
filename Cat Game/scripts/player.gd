extends CharacterBody2D
class_name Player

signal took_damage(amount)

@export var gravity = 400
@export var jump_velocity = 200
@export var speed = 135
@export var damage = 1
var last_direction = 1
var can_shoot = true

var bullet_scene = preload("res://scenes/bullet.tscn")

@onready var sprite = $AnimatedSprite2D
@onready var bullet_container = $BulletContainer
@onready var timer = $Timer
	
func _process(_delta):
	if Input.is_action_just_pressed("shoot") && can_shoot:
		can_shoot = false
		timer.start()
		shoot()

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_velocity
	
	var direction = 0
	direction = Input.get_axis("move_left", "move_right")
	if (direction != 0):
		sprite.flip_h = (direction == -1)
		last_direction = direction
		
	velocity.x = direction * speed

	move_and_slide()
	
	update_animations(direction)

func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			sprite.play("idle")
		else:
			sprite.play("walking")
	else:
		sprite.play("jump")
		
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.set_direction(last_direction)
	bullet.set_damage(damage)
	bullet_container.add_child(bullet)
	bullet.global_position = global_position
	bullet.global_position.x += last_direction * 15

func _on_timer_timeout():
	can_shoot = true

func take_damage(amount):
	emit_signal("took_damage", amount)
