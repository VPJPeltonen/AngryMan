extends Area2D

var counter = 0
var grow_speed = 30
var lifetime = 1.5
var rotation_speed = 1

func _process(delta):
	counter += delta
	scale += Vector2(0.1,0.1) * grow_speed * delta
	rotation_degrees += rotation_speed
	if counter >= lifetime:
		queue_free()
	
func start(new_pos):
	position = new_pos


func _on_PowerBlast_body_entered(body):
	if body.is_in_group("characters"):
		if !body.player:
			print("hit")
			body.damage(1)
