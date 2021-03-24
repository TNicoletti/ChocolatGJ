extends KinematicBody2D

const MOVESPEED_N = 100
const MOVESPEED_T = MOVESPEED_N*2/3

var movespeed = MOVESPEED_N


func _ready():
	
	pass
	
func _physics_process(delta):
	var motion = Vector2()
	
	if(Input.is_action_pressed("move_up"))
	pass
