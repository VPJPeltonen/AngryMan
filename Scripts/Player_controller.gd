extends KinematicBody2D

var move_speed = 50
var move_dir = Vector2()
var on_ground = false
var jump_force = 1000
var jumps = 1

func _ready():
	pass # Replace with function body.

func _process(delta):
	var move_state = "stand"
	if Input.is_action_pressed("move_left"):
		move_state = "walk"
		move_dir.x -= move_speed
	elif Input.is_action_pressed("move_right"):
		move_state = "walk"
		move_dir.x += move_speed
	
	if Input.is_action_just_pressed("jump") and jumps > 0:
		move_dir.y -= jump_force
		jumps -= 1
	
	if !on_ground:
		move_dir.y += 20
	else: 
		jumps = 1
	
	move_dir = move_dir.linear_interpolate(Vector2(0,0), delta*6)
	move_and_slide(move_dir)
	$Sprite.set_state(move_state,move_dir)


func _on_Feet_body_entered(body):
	if body.is_in_group("ground"):
		on_ground = true


func _on_Feet_body_exited(body):
	if body.is_in_group("ground"):
		on_ground = false
