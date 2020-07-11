extends KinematicBody2D

export var health = 1
export var move_speed = 40

var on_ground = false
var move_dir = Vector2()
var player = false

func _ready():
	add_to_group("characters")

func damage(damage_done):
	health -= damage_done
	$Sprite.show_damage()
	if health <= 0:
		die()
		
func die():
	queue_free()

func _on_Feet_body_entered(body):
	if body.is_in_group("ground"):
		on_ground = true

func _on_Feet_body_exited(body):
	if body.is_in_group("ground"):
		on_ground = false
