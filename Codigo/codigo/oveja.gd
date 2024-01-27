extends CharacterBody2D

@onready var all_interactions = []
@onready var interactLabel = $"Interaction Components/InteractLabel"

var speed = 10.0
var total_value_objects = 0

func _ready():
	update_interactions()

func _physics_process(delta):
	velocity = Vector2(velocity.x-velocity.x/6, velocity.y-velocity.y/6)
	
	if(Input.is_action_pressed("down")):
		velocity.y += speed
	if(Input.is_action_pressed("up")):
		velocity.y -= speed
	if(Input.is_action_pressed("left")):
		velocity.x -= speed
	if(Input.is_action_pressed("right")):
		velocity.x += speed
	
	velocity.limit_length(30)

	move_and_slide()
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()
		
	if Input.is_action_just_pressed("finish_shopping"):
		print(total_value_objects)
		if(total_value_objects == 10):
			get_tree().change_scene_to_file("res://escenas/gameplay.tscn")

func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()

func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interactLabel.text = all_interactions[0].interact_label
	else:
		interactLabel.text = ""
		
func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		match cur_interaction.interact_type:
			"print_text" :
				add_object_value(cur_interaction.interact_value)
				print(cur_interaction.interact_value)

func add_object_value(value):
	total_value_objects += value
