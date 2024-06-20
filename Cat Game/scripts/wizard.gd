extends Enemy

@export var damage = 3
var can_shoot = false

var bullet_scene = preload("res://scenes/bullet.tscn")

@onready var bullet_container = $BulletContainer
@onready var timer = $Timer

func _ready():
	health = max_health
	timer.start()

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
		
	var diff = player.global_position.x - global_position.x
	if (diff > 0):
		direction = 1
		sprite.flip_h = false
	else:
		direction = -1
		sprite.flip_h = true

func _process(_delta):
	if can_shoot:
		can_shoot = false
		sprite.play("shoot")
		timer.start()
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.set_direction(direction)
	bullet.set_damage(damage)
	bullet.collision_mask = (1 << 1) | (1 << 0)
	bullet_container.add_child(bullet)
	bullet.global_position = global_position
	bullet.global_position.x += direction 

func _on_timer_timeout():
	can_shoot = true
