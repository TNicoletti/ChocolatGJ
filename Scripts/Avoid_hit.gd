extends Area2D

var runaway = []

onready var kb2d: = get_parent()

var runforce = 20

func _process(delta):
	for i in runaway:
		kb2d.move_and_slide(kb2d.position.direction_to(i.position) * -runforce)
		pass
	pass

func _on_Avoid_hit_area_body_entered(body):
	if(body.name != kb2d.name):
		runaway.append(body)
	pass # Replace with function body.


func _on_Avoid_hit_area_body_exited(body):
	if(body.name != kb2d.name):
		runaway.remove(runaway.find(body))
	pass # Replace with function body.
