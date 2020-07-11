extends Node2D

var counter = 0
var lifetime = 1.5
var active = false
var in_range = []
var damage = 1

func _process(delta):
	if active:
		counter += delta
		for body in in_range:
			body.damage(delta*damage)
		if counter >= lifetime:
			counter = 0
			active = false
			hide()

func _on_Area2D_body_entered(body):
	if body.is_in_group("characters"):
		if !body.player:
			in_range.append(body)

func _on_Area2D_body_exited(body):
	if in_range.has(body):
		in_range.remove(in_range.find(body))
