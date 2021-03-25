extends Sprite

var normal = preload("res://Images/topDown_ch_01.png")
var pt1 = preload("res://Images/Bunny1.png")

var patent = 0

var enemys_range = []

onready var sprite = get_parent().get_node("Sprite")

func _process(delta):
	if(Input.is_action_just_pressed("Transform") && enemys_range.size() > 0):
		transform(enemys_range[0])
		enemys_range.remove(0)
		#sprite.set_texture(pt1);
	pass

func transform(body):
	patent = body.patent
	print("New patent: " + str(patent))
	
	var ntexture = body.get_node("Sprite");
	sprite.set_texture(ntexture.get_texture());
	body.queue_free()

func _on_Transform_Area_body_entered(body):
	if("Enemy" in body.name):
		enemys_range.append(body)
	pass # Replace with function body.


func _on_Transform_Area_body_exited(body):
	if("Enemy" in body.name):
		enemys_range.remove(enemys_range.find(body))
	pass # Replace with function body.
