extends CanvasLayer

var power_display = false
var power_display_timer = 0

func _process(delta):
	if power_display:
		power_display_timer -= delta
		if power_display_timer <= 0:
			$Power_used.hide()
			power_display = false

func _on_Player_power_used(power_used, next_power, type):
	$Power_used.show()
	$Power_used.text = power_used
	power_display = true
	power_display_timer = 1
	if type == "off":
		$off_power/Label.text = next_power
	else:
		$def_power/Label.text = next_power
