extends "res://Scripts/Characters/Character.gd"

var jump_force = 1000
var jumps = 1
var walk_counter = 0
var walk_dir = Vector2(move_speed,0)


func _process(delta):
	if !on_ground:
		move_dir.y += 1000 * delta
	else: 
		jumps = 1
	
	walk_counter += delta
	if walk_counter >= 4:
		walk_dir = -walk_dir
		walk_counter = 0
	move_dir = Vector2(walk_dir.x,move_dir.y)
	move_dir = move_dir.linear_interpolate(Vector2(0,0), delta*6)
	move_and_slide(move_dir)
	if move_dir.x < 0:
		$Sprite.scale.x = -1
	elif move_dir.x > 0:
		$Sprite.scale.x = 1
