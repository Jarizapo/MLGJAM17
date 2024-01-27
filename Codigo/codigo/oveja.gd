extends CharacterBody2D

@onready var all_interactions = []
@onready var interactLabel = $"Interaction Components/InteractLabel"

var speed = 10.0
var objects = []
var objectBeingCatched
var numberOfObjects = 0
@onready var areas = [
				$"../Objetos/Tinte/InteractArea",
				$"../Objetos/Tijeras/InteractArea",
				$"../Objetos/Taza/InteractArea",
				$"../Objetos/Tanga/InteractArea",
				$"../Objetos/Pintapezuñas/InteractArea",
				$"../Objetos/Payaso/InteractArea",
				$"../Objetos/Desatascador/InteractArea",
				$"../Objetos/Bombones/InteractArea"
			]

func _ready():
	update_interactions()
	objects.resize(8)
	objects.fill(false)

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
		print(objects)
		if(objects[0] == true):
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
				add_object(cur_interaction.interact_value)
				print(cur_interaction.interact_value)

func add_object(object):
	if(numberOfObjects < 2):
		match object:
			"bombones":
				objects.insert(5, true)
				objectBeingCatched = $"../Objetos/Bombones"
				$"../Objetos/Bombones/InteractArea".interact_label = ""
				areas.remove_at(7)
			"desatascador":
				objects.insert(8, true)
				objectBeingCatched = $"../Objetos/Desatascador"
				$"../Objetos/Desatascador/InteractArea".interact_label = ""
				areas.remove_at(6)
			"payaso":
				objects.insert(3, true)
				objectBeingCatched = $"../Objetos/Payaso"
				$"../Objetos/Payaso/InteractArea".interact_label = ""
				areas.remove_at(5)
			"pintapezuñas":
				objects.insert(0, true)
				objectBeingCatched = $"../Objetos/Pintapezuñas"
				$"../Objetos/Pintapezuñas/InteractArea".interact_label = ""
				areas.remove_at(4)
			"tanga":
				objects.insert(4, true)
				objectBeingCatched = $"../Objetos/Tanga"
				$"../Objetos/Tanga/InteractArea".interact_label = ""
				areas.remove_at(3)
			"taza":
				objects.insert(6, true)
				objectBeingCatched = $"../Objetos/Taza"
				$"../Objetos/Taza/InteractArea".interact_label = ""
				areas.remove_at(2)
			"tijeras":
				objects.insert(7, true)
				objectBeingCatched = $"../Objetos/Tijeras"
				$"../Objetos/Tijeras/InteractArea".interact_label = ""
				areas.remove_at(1)
			"tinte":
				objects.insert(1, true)
				objectBeingCatched = $"../Objetos/Tinte"
				$"../Objetos/Tinte/InteractArea".interact_label = ""
				areas.remove_at(0)
		
		objectBeingCatched.get_parent().remove_child(objectBeingCatched)
		add_child(objectBeingCatched)
		if(numberOfObjects == 0):
			objectBeingCatched.transform.origin = Vector2(3,-10)
		elif(numberOfObjects == 1):
			objectBeingCatched.transform.origin = Vector2(3,-20)
			
			for area in areas:
				if(area != null):
					area.interact_label = ""
					
		numberOfObjects += 1
