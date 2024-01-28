extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	await get_tree().create_timer(0.5).timeout
	if(Input.is_action_pressed("continue")):
		get_tree().change_scene_to_file("res://escenas/historia/meme_whatsapp.tscn")
