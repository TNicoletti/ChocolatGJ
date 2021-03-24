extends KinematicBody2D

const PLAYER_COLLISION_BIT = 1


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Sight_area_entered(area: Area2D):
	print("on_area_entered")
	if area.get_collision_layer_bit(PLAYER_COLLISION_BIT):
		print("player")
		detect(area)

func detect(area: Node):
	if area.has_signal("raise_detection"):
		area.emit_signal("raise_detection")

