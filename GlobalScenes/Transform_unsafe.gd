extends Area2D

var enemies_in_area: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Transform_unsafe_body_entered(body):
	if("Enemy" in body.name):
		enemies_in_area += 1
	pass # Replace with function body.


func _on_Transform_unsafe_body_exited(body):
	if("Enemy" in body.name):
		enemies_in_area -= 1
	pass # Replace with function body.
