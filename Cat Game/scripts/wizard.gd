extends Enemy

@export var damage = 3
var can_shoot = true

var bullet_scene = preload("res://scenes/bullet.tscn")

@onready var bullet_container = $BulletContainer
@onready var timer = $Timer

func _process(_delta):
	if can_shoot:
		can_shoot = false
		timer.start()
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.set_direction(direction)
	bullet.set_damage(damage)
	bullet_container.add_child(bullet)
	bullet.global_position = global_position
	bullet.global_position.x += direction * 20

func _on_timer_timeout():
	can_shoot = true
