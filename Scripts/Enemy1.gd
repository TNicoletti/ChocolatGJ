extends Node

var patent = 1

var detection_level = 0

const DETECTION_INCREASE_FACTOR = 0.1
const DETECTION_DECREASE_FACTOR = 0.05
var detected: bool = false

onready var player_patent = get_parent().get_node("../Player/Sprite")

onready var lbl_detection = get_parent().get_node("Dtl")

func _ready():
	get_parent().get_node("Patent").refresh(patent)
	pass
	
#onready var movement_enemy = get_node("Movement_enemy")

func _process(delta):
	
	detection_handle(delta)
	
	
func detection_handle(_delta):
	if(detected && player_patent.patent < patent):
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
