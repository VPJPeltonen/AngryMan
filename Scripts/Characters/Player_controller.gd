extends "res://Scripts/Characters/Character.gd"

signal power_used(power_used,next_power,type)

var rng = RandomNumberGenerator.new()

var jump_force = 1000
var jumps = 1

var current_def_power = "none"
var current_off_power = "none"
var def_powers = [
	"speed boost",
	"force field"
]
var off_powers = [
	"blast",
	"beam"
]
var off_power_cooldown = 0
var def_power_cooldown = 0

var speed_boost = 1
var boost_counter = 0
var boost_active = false
var active_boost = "none"

var power_blast = preload("res://Scenes/Effects/PowerBlast.tscn")

func _ready():
	player = true
	add_to_group("characters")
	rng.randomize()
	current_def_power = set_power(def_powers)
	current_off_power = set_power(off_powers)
	emit_signal("power_used","",current_def_power,"def")
	emit_signal("power_used","",current_off_power,"off")
	
func _process(delta):
	move(delta)
	if Input.is_action_just_pressed("use_power1") and def_power_cooldown <= 0:
		power("def")
	if Input.is_action_just_pressed("use_power2") and off_power_cooldown <= 0:
		power("off")
	if boost_active:
		boost_counter -= delta
		if boost_counter <= 0:
			disable_boost(active_boost)
	if off_power_cooldown > 0:
		off_power_cooldown -= delta
	if def_power_cooldown > 0:
		def_power_cooldown -= delta
	
func set_power(powerset):
	return powerset[rng.randi_range(0,powerset.size()-1)]
			
func disable_boost(boost):
	boost_active = false
	match boost: 
		"speed":
			$Speed_effect.emitting = false
			speed_boost = 1
		"force field":
			$ForceField.hide()
		
func start_boost(boost,boost_time):
	boost_active = true
	boost_counter = boost_time
	active_boost = boost
		
func power(powertype):
	var power_used
	var new_power
	if powertype == "off":
		match current_off_power:
			"blast":
				var b = power_blast.instance()
				b.start(global_position)
				get_parent().add_child(b)
			"beam":
				$Sprite/Beam.show()
				$Sprite/Beam.active = true
		power_used = current_off_power
		current_off_power = set_power(off_powers)
		new_power = current_off_power
		off_power_cooldown = 2
	else:
		match current_def_power:
			"speed boost":
				$Speed_effect.emitting = true
				speed_boost = 2
				start_boost("speed",3)
			"force field":
				$ForceField.show()
				start_boost("force field",3)
		power_used = current_def_power
		current_def_power = set_power(def_powers)
		new_power = current_def_power
		def_power_cooldown = 3
	emit_signal("power_used",power_used,new_power,powertype)

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
