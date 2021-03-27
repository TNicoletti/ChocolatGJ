extends Node

var patent = 1

var detection_level = 0

const DETECTION_INCREASE_FACTOR = 0.1
const DETECTION_DECREASE_FACTOR = 0.05
var detected: bool = false

#improving detection, against seeing through walls
onready var rc2D: = get_node("../RayCast2D")
onready var flipped: = get_parent()


onready var player_patent = get_parent().get_node("../Player/Sprite")

onready var lbl_detection = get_parent().get_node("Dtl")

func _ready():
	get_parent().get_node("Patent").refresh(patent)
	pass
	
#onready var movement_enemy = get_node("Movement_enemy")

func _process(delta):
	
	detection_handle(delta)
	
	
func detection_handle(_delta):
	var dt = detected
	if(detected):
		var v = rc2D.global_position.direction_to(player_patent.global_position).normalized() * 150
		if(flipped.fliped):
			v = -v
		rc2D.cast_to = v
		if(!rc2D.is_colliding() || !("Player" in rc2D.get_collider().name)):
			dt = false
			
	if(dt && player_patent.patent < patent):
		if(player_patent.patent == 0):
			get_tree().reload_current_scene()
		detection_level += DETECTION_INCREASE_FACTOR
	else:
		detection_level -= DETECTION_DECREASE_FACTOR
	detection_level = clamp(detection_level, 0, 100)
	
	if(detection_level >= 50):
		#movement_enemy.state = 1
		get_tree().reload_current_scene()
	
	#Test
	lbl_detection.text = str("Detection: " + str("%0.2f" % detection_level))

func _on_Sight_body_entered(body):
	if("Player" in body.name):
		detected = true
	pass


func _on_Sight_body_exited(body):
	if("Player" in body.name):
		detected = false
	pass
