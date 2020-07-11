extends Sprite

var movement = Vector2(0,0)
var speed = 100
var lifetime_counter = 0

func _process(delta):
	position += delta*movement*speed
	lifetime_counter += delta
	if lifetime_counter > 10:
		queue_free()

func start(start_pos,start_scale):
	position = start_pos
	scale.x = start_scale
	movement = Vector2(start_scale,0)
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("characters"):
		if body.player:
			body.damage(1)
	elif body.is_in_group("ground"):
		queue_free()
