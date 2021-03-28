extends KinematicBody2D

enum {IDLE, PURSUIT, STOP}

export var state = IDLE

const SPEED_NORMAL = 250
const SPEED_IDLE = 100

var speed = 250
var stuck_timer = 30

onready var player = get_parent().get_node("Player")

onready var player_patent = get_node("../Player/Sprite")

onready var initial_texture = preload("res://Images/Bunny2.png")
onready var texture_mau = preload("res://Images/Coelho_mau.png")
onready var texture = get_node("Sprite")

#onready var flip_anim = get_node("Sprite")

#Navigation2d(Pathfinding variables)
var rng = RandomNumberGenerator.new()
onready var nav2d: Navigation2D = get_parent().get_node("Navigation2D")
onready var testpath: Line2D = get_parent().get_node("Line2D")
var has_path: bool = false
var path

#func _unhandled_input(event):
#	if(not event is InputEventMouseButton):
#		return
#
#	if(event.button_index != BUTTON_LEFT or not event.pressed):
#		return
#
#	var new_path: = nav2d.get_simple_path(global_position, get_global_mouse_position(), false)
#	#print(get_global_mouse_position())
#	path = new_path
#	testpath.points = new_path
#	if(new_path.size() > 0):
#		has_path = true

func _ready():
	rng.randomize()

var velocity = 0

func _physics_process(delta):
	
	if(player_patent.patent == -1):
		state = PURSUIT
		texture.set_texture(texture_mau);
	else:
		state = STOP
		texture.set_texture(initial_texture);
	
	match(state):
		IDLE:
			speed = SPEED_IDLE
			idle_move()
		PURSUIT:
			speed = SPEED_NORMAL
			pursuit_move2()
	
	pass # Replace with function body.

func move_along_path():
	if(!has_path):
		return
		
	var error_margin = speed / 60 #+ (16 * 5 / 2)
	var start_point = position
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if(error_margin <= abs(distance_to_next)) and (stuck_timer > 0):
			var direc = position.direction_to(path[0])
			flip_to(direc)
			var final_velocity = move_and_slide(direc * speed)
			
			if final_velocity.length() < 1:
				stuck_timer -= 1
			return
		stuck_timer = 30
		start_point = path[0]
		path.remove(0)
		if(path.size() == 0):
			has_path = false
			return
		if(path.size() == i):
			return


func idle_move():
	while(!has_path):
		var pos =  position
		var margin = 500
		pos.x += rng.randf_range(-margin, margin)
		pos.x += fmod(pos.x + 40, 80)
		pos.y += rng.randf_range(-margin, margin)
		pos.y += fmod(pos.y + 40, 80)
		
		var new_path: = nav2d.get_simple_path(position, pos, false)
		
		if(new_path.size() == 0 || new_path[new_path.size() - 1] != pos):
			return
		
		testpath.points = new_path
		path = new_path
		#if(new_path.size() > 0):
		has_path = true
	
	move_along_path()
	pass

var fliped = false
func flip_to(motion):
	if(motion.x < 0):
		if(!fliped):
			scale.x = -scale.x
			fliped = true
	elif(motion.x > 0):
		if(fliped):
			scale.x = -scale.x
			fliped = false

func pursuit_move():
	velocity = position.direction_to(player.position) * speed
	move_and_slide(velocity)
	pass
	
func pursuit_move2():
	if(!has_path):
		var new_path: = nav2d.get_simple_path(global_position, player.global_position)
		if(new_path.size() > 0):
			has_path = true
			path = new_path
	
	move_along_path()
	pass
