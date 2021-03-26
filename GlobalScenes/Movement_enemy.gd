extends Node

enum {IDLE, PURSUIT}

var state = IDLE

var speed = 250

onready var parent = get_parent()
onready var player = parent.get_parent().get_node("Player")

var velocity = 0

func _physics_process(delta):
	
	match(state):
		IDLE:
			idle_move()
		PURSUIT:
			pursuit_move()
	
	pass # Replace with function body.

func idle_move():
	pass
	
func pursuit_move():
	velocity = parent.position.direction_to(player.position) * speed
	parent.move_and_slide(velocity)
	pass
