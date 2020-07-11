extends "res://Scripts/Characters/Character.gd"

var jump_force = 1000
var jumps = 1
var walk_counter = 0
var walk_dir = Vector2(move_speed,0)
var player_in_range = false
var shoot_cooldown = 0

var bullet = preload("res://Scenes/Effects/bullet.tscn")

func _process(delta):
	if !on_ground:
		move_dir.y += 1000 * delta
	else: 
		jumps = 1
	
	if player_in_range:
		$Sprite.set_animation("shoot")
		if shoot_cooldown <= 0:
			shoot()
		else: 
			shoot_cooldown -= delta
	else:
		$Sprite.set_animation("default")
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

func shoot():
	var b = bullet.instance()
	b.start($Sprite/barrel.global_position,$Sprite.scale.x)
	get_parent().add_child(b)
	shoot_cooldown = 1

func _on_aimzone_body_entered(body):
	if body.is_in_group("characters"):
		if body.player:
			player_in_range = true

func _on_aimzone_body_exited(body):
	if body.is_in_group("characters"):
		if body.player:
			player_in_range = false
