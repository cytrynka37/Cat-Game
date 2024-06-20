extends Enemy

@export var speed = 40

@onready var game = get_parent().get_parent()
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		sprite.flip_h = false		
	position.x += speed * delta * direction
	
func _on_hitbox_body_entered(body):
	body.take_damage(game.health)
