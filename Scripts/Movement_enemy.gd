extends Node

enum {IDLE, PURSUIT}

var state = IDLE

const SPEED_NORMAL = 250
const SPEED_IDLE = 50

var speed = 250

onready var parent = get_parent()
onready var player = parent.get_parent().get_node("Player")

#Navigation2d(Pathfinding variables)
var rng = RandomNumberGenerator.new()
onready var nav2d: Navigation2D = parent.get_parent().get_node("Navigation2D")
onready var testpath: Line2D = parent.get_parent().get_node("Line2D")
var has_path: bool = false
var path

func _unhandled_input(event):
	if(not event is InputEventMouseButton):
		return

	if(event.button_index != BUTTON_LEFT or not event.pressed):
		return

	var new_path: = nav2d.get_simple_path(parent.global_position, event.global_position)
	path = new_path
	testpath.points = new_path
	if(new_path.size() > 0):
		has_path = true

func _ready():
	rng.randomize()

var velocity = 0

func _physics_process(delta):
	
	match(state):
		IDLE:
			#speed = SPEED_IDLE
			idle_move()
		PURSUIT:
			#speed = SPEED_NORMAL
			pursuit_move2()
	
	pass # Replace with function body.

func move_along_path():
	if(!has_path):
		return
		
	var error_margin = speed / 60 #+ (16 * 5 / 2)
	var start_point = parent.position
	for i in range(path.size()):
		var distance_to_next = start_point.distance_to(path[0])
		if(error_margin <= abs(distance_to_next)):
			parent.move_and_slide(parent.position.direction_to(path[0]) * speed)
			return
		start_point = path[0]
		path.remove(0)
		if(path.size() == 0):
			has_path = false
			return
		if(path.size() == i):
			return


func idle_move():
	while(!has_path):
		var pos =  parent.global_position
		var margin = 50
		pos.x += rng.randf_range(-margin, margin)
		pos.y += rng.randf_range(-margin, margin)
		
		var new_path: = nav2d.get_simple_path(parent.global_position, pos)
		testpath.points = new_path
		path = new_path
		if(new_path.size() > 0):
			has_path = true
	
	move_along_path()
	pass
	
func pursuit_move():
	velocity = parent.position.direction_to(player.position) * speed
	parent.move_and_slide(velocity)
	pass
	
func pursuit_move2():
	var new_path: = nav2d.get_simple_path(parent.global_position, player.global_position)
	if(new_path.size() > 0):
		has_path = true
		path = new_path
	
	move_along_path()
	pass
