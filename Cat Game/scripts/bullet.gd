extends Area2D

@export var speed = 500
var direction = 1
@export var damage = 1

func set_damage(amount):
	damage = amount

func set_direction(new_direction):
	direction = new_direction

func _physics_process(delta):
	global_position.x += speed * direction * delta

func _on_body_entered(body):
	queue_free()
	body.take_damage(damage)
