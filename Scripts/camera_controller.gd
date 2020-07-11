extends Camera2D

var player
var camera_speed = 5

func _ready():
	player = get_parent().get_node("Player")

func _process(delta): 
	position = position.linear_interpolate(player.position, delta*camera_speed)
