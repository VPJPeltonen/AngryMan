extends "res://Scripts/Characters/Character.gd"

var jump_force = 1000
var jumps = 1


func _process(delta):
	if !on_ground:
		move_dir.y += 1000 * delta
	else: 
		jumps = 1
	
	move_dir = move_dir.linear_interpolate(Vector2(0,0), delta*6)
	move_and_slide(move_dir)
