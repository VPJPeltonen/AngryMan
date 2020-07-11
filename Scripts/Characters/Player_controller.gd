extends "res://Scripts/Characters/Character.gd"

var jump_force = 1000
var jumps = 1

var speed_boost = 1
var boost_counter = 0
var boost_active = false
var active_boost = "none"

var power_blast = preload("res://Scenes/Effects/PowerBlast.tscn")

func _ready():
	player = true
	add_to_group("characters")

func _process(delta):
	move(delta)
	if Input.is_action_just_pressed("use_power1"):
		power(1)
	if Input.is_action_just_pressed("use_power2"):
		power(2)
	if boost_active:
		boost_counter -= delta
		if boost_counter <= 0:
			disable_boost(active_boost)
			
func disable_boost(boost):
	boost_active = false
	match boost: 
		"speed":
			$Speed_effect.emitting = false
			speed_boost = 1
		
func start_boost(boost,boost_time):
	boost_active = true
	boost_counter = boost_time
	active_boost = boost
		
func power(powernum):
	if powernum == 1:
		var b = power_blast.instance()
		b.start(global_position)
		get_parent().add_child(b)
	else:
		$Speed_effect.emitting = true
		speed_boost = 2
		start_boost("speed",5)
		

func move(delta):
	var move_state = "stand"
	if Input.is_action_pressed("move_left"):
		move_state = "walk"
		move_dir.x -= move_speed * speed_boost
	elif Input.is_action_pressed("move_right"):
		move_state = "walk"
		move_dir.x += move_speed * speed_boost
	
	if Input.is_action_just_pressed("jump") and jumps > 0:
		move_dir.y -= jump_force
		jumps -= 1
	
	if !on_ground:
		move_dir.y += 1000 * delta
	else: 
		jumps = 1
	
	move_dir = move_dir.linear_interpolate(Vector2(0,0), delta*6)
	move_and_slide(move_dir)
	$Sprite.set_state(move_state,move_dir)
