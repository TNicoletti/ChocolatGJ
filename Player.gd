extends KinematicBody2D

const MOVESPEED_N = 300
const MOVESPEED_T = MOVESPEED_N*2/3
const DETECTION_INCREASE_FACTOR = 0.1
const DETECTION_DECREASE_FACTOR = 0.05
const ENEMY_SIGHT_BIT = 1

var movespeed = MOVESPEED_N

var detection_level = 0
var detected: bool
var rank = 0

onready var flip_anim = get_node("Sprite")

func _ready():
	detected = false
	pass
	
func _physics_process(delta):
	#print(global_position)
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
	
	#look_at(get_global_mouse_position())
	flip_to(motion)
	pass
	
	if detected:
		raise_detection()
	
	if !detected and detection_level > 0:
		detection_level -= DETECTION_DECREASE_FACTOR
	
	# Test code
	$DetectionLevelActual.refresh()


func flip_to_mouse(mouse_pos):
	if(mouse_pos.x < position.x):
		flip_anim.set_flip_h(false)
	else:
		flip_anim.set_flip_h(true)
		
func flip_to(motion):
	if(motion.x > 0):
		flip_anim.set_flip_h(false)
	elif(motion.x < 0):
		flip_anim.set_flip_h(true)
		

func raise_detection():
	detection_level += DETECTION_INCREASE_FACTOR
	#print(detection_level)


func _on_Area2D_area_entered(area: Area2D):
	#print("area_entered")
	if area.get_collision_layer_bit(ENEMY_SIGHT_BIT):
		#print("enemy")
		detected = true


func _on_Area2D_area_exited(area: Area2D):
	#print("area_exited")
	if area.get_collision_layer_bit(ENEMY_SIGHT_BIT):
		#print("enemy")
		detected = false
