extends StaticBody2D
export var min_rank: int
export var max_rank: int

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if("Player" in body.name):
		if(body.rank >= min_rank) and (body.rank <= max_rank):
			$BlockCollision.set_deferred("disabled", true)
			
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	$BlockCollision.set_deferred("disabled", false)
