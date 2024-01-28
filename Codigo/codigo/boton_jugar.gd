extends TextureButton

@onready var escena = "res://escenas/historia/oveja_rosaleda.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(button_pressed):
		get_tree().change_scene_to_file(escena)
