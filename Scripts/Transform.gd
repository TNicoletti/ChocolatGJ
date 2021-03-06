extends Sprite

var normal_texture = preload("res://Images/Slime_de_Chocolate.png")

var patent = 0

var enemys_range = []

onready var patent_anim = get_parent().get_node("Patent")

onready var normal_scale = transform.get_scale()

onready var transform_unsafe = get_node("../Transform_unsafe")

func _process(delta):
	if(Input.is_action_just_pressed("Transform") && enemys_range.size() > 0):
		for i in range(enemys_range.size()):
			if(enemys_range[i].get_node("Movement_enemy").transformable):
				transform(enemys_range[i])
				enemys_range.remove(i)
				break
		#sprite.set_texture(pt1);
	elif((Input.is_action_just_pressed("Transform") || Input.is_action_just_pressed("Return_normal")) && patent != 0):
		return_normal()
	pass

func return_normal():
	patent = 0
	get_parent().rank = 0
	#print("New patent: 0")
	patent_anim.refresh(patent)
	
	set_texture(normal_texture);
	scale = (normal_scale)

func transform(body):
	if(transform_unsafe.enemies_in_area > 1):
		#print(transform_unsafe.enemies_in_area)
		get_tree().reload_current_scene()
	
	var npatent = body.get_node("Movement_enemy").patent
	patent = npatent
	get_parent().rank = npatent
	#print("New patent: " + str(patent))
	patent_anim.refresh(patent)
	
	var ntexture = body.get_node("Sprite");
	set_texture(ntexture.get_texture());
	scale = ntexture.scale
	body.queue_free()

func _on_Transform_Area_body_entered(body):
	if("Enemy" in body.name):
		enemys_range.append(body)
	pass # Replace with function body.


func _on_Transform_Area_body_exited(body):
	if("Enemy" in body.name):
		enemys_range.remove(enemys_range.find(body))
	pass # Replace with function body.
