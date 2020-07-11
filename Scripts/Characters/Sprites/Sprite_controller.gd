extends AnimatedSprite

var blinks = 0
var blink_counter = 0
var blinking = false

func _process(delta):
	if blinking:
		
		if blinks >= 8:
			blinking = false
			blink_counter = 0
			blinks = 0
		blink_counter += delta
		if blink_counter >= 0.1:
			if get_self_modulate() == Color(1,1,1,1):
				set_self_modulate(Color(1,0,0,1)) 
			else:
				set_self_modulate(Color(1,1,1,1)) 
			blink_counter = 0
			blinks += 1
			
func show_damage():
	blinking = true
