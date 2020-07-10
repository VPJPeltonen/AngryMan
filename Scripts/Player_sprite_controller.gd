extends AnimatedSprite

func set_state(state,dir):
	set_animation(state)
	if dir.x < 0:
		scale.x = -1
	elif dir.x > 0:
		scale.x = 1
	if dir.y < 0:
		set_animation("up")
	elif dir.y > 50:
		set_animation("fall")
