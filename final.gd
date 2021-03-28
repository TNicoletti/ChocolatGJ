extends Area2D

export var path: String


func _on_Area2D_body_entered(body):
	if("Player" in body.name):
		get_tree().change_scene(path)
	pass # Replace with function body.
