extends KinematicBody2D

const MOVESPEED_N = 300
const MOVESPEED_T = MOVESPEED_N*2/3

var movespeed = MOVESPEED_N


func _ready():
	
	pass
	
func _physics_process(delta):
	var motion = Vector2()
	
	if(Input.is_action_pressed("move_up")):
		motion.y -= 1
	if(Input.is_action_pressed("move_down")):
		motion.y += 1
	if(Input.is_action_pressed("move_left")):
		motion.x -= 1
	if(Input.is_action_pressed("move_right")):
		motion.x += 1
	
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	
	look_at(get_global_mouse_position())
	pass
