extends CharacterBody2D

@onready var all_interactions = []
@onready var interactLabel = $"Interaction Components/InteractLabel"

var speed = 10.0
var objects = [false, false, false, false, false, false, false, false]
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

func _process(delta):
	if(numberOfObjects == 2):
		for area in areas:
			if(area != null):
				area.interact_label = ""

func _physics_process(delta):
	velocity = Vector2(velocity.x-velocity.x/6, velocity.y-velocity.y/6)
	
	if(Input.is_action_pressed("down")):
		velocity.y += speed
	if(Input.is_action_pressed("up")):
		velocity.y -= speed
	if(Input.is_action_pressed("left")):
		velocity.x -= speed
		$Sprite2D.flip_h = false
	if(Input.is_action_pressed("right")):
		velocity.x += speed
		$Sprite2D.flip_h = true
	
	velocity.limit_length(30)

	move_and_slide()
	
	if Input.is_action_just_pressed("interact"):
		execute_interaction()
		
	var cadena
		
	if Input.is_action_just_pressed("finish_shopping"):
		print(objects)
		if((objects[0] || objects[4]) && (objects[3] || objects[5])):
			# Aquí hay que hacer la diferencia entre si le regala el tinte o pintapezuñas
			# Y si se disfraza de una cosa u otra (hay que hacer 4 escenas)
			#if(objects[0] && objects[3]):
				#se pone la escena de tinte y tanga
			#elif(objects[0] && objects[5]):
				#se pone la escena de tinte y payaso
			#elif(objects[4] && objects[3]):
				#se pone la escena de pintapezunas y tanga
			#elif(objects[4] && objects[5]):
				#se pone la escena de pintapezuñas y payaso
			cadena = "res://escenas/finales/antienfado_antitristeza.tscn"
		elif((objects[0] && objects[4]) || ((objects[0] || objects[4]) && (objects[2] || objects[7]))):
			cadena = "res://escenas/finales/antienfado.tscn"
		elif((objects[3] && objects[5]) || ((objects[3] || objects[5]) && (objects[2] || objects[7]))):
			cadena = "res://escenas/finales/antitristeza.tscn"
		elif(objects[2] && objects[7]):
			cadena = "res://escenas/finales/nada.tscn"
		elif(objects[1] && objects[6]):
			cadena = "res://escenas/finales/2malo.tscn"
		elif(objects[1] || objects[6]):
			cadena = "res://escenas/finales/1malo.tscn"
		
		get_tree().change_scene_to_file(cadena)

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
			"exit" :
				print(1)
				#get_tree().change_scene_to_file("res://escenas/historia/oveja_rosaleda.tscn")

func add_object(object):
	if(numberOfObjects < 2):
		match object:
			"bombones":
				objects[7] = true
				objectBeingCatched = $"../Objetos/Bombones"
				if($"../Objetos/Bombones/InteractArea" != null):
					$"../Objetos/Bombones/InteractArea".interact_label = ""
				if(areas.size() == 7):
					areas.remove_at(6)
				elif(areas.size() == 8):
					areas.remove_at(7)
			"desatascador":
				objects[6] = true
				objectBeingCatched = $"../Objetos/Desatascador"
				if($"../Objetos/Desatascador/InteractArea" != null):
					$"../Objetos/Desatascador/InteractArea".interact_label = ""
				areas.remove_at(6)
			"payaso":
				objects[5] = true
				objectBeingCatched = $"../Objetos/Payaso"
				if($"../Objetos/Payaso/InteractArea" != null):
					$"../Objetos/Payaso/InteractArea".interact_label = ""
				areas.remove_at(5)
			"pintapezuñas":
				objects[4] = true
				objectBeingCatched = $"../Objetos/Pintapezuñas"
				if($"../Objetos/Pintapezuñas/InteractArea" != null):
					$"../Objetos/Pintapezuñas/InteractArea".interact_label = ""
				areas.remove_at(4)
			"tanga":
				objects[3] = true
				objectBeingCatched = $"../Objetos/Tanga"
				if($"../Objetos/Tanga/InteractArea" != null):
					$"../Objetos/Tanga/InteractArea".interact_label = ""
				areas.remove_at(3)
			"taza":
				objects[2] = true
				objectBeingCatched = $"../Objetos/Taza"
				if($"../Objetos/Taza/InteractArea" != null):
					$"../Objetos/Taza/InteractArea".interact_label = ""
				areas.remove_at(2)
			"tijeras":
				objects[1] = true
				objectBeingCatched = $"../Objetos/Tijeras"
				if($"../Objetos/Tijeras/InteractArea" != null):
					$"../Objetos/Tijeras/InteractArea".interact_label = ""
				areas.remove_at(1)
			"tinte":
				objects[0] = true
				objectBeingCatched = $"../Objetos/Tinte"
				if($"../Objetos/Tinte/InteractArea" != null):
					$"../Objetos/Tinte/InteractArea".interact_label = ""
				areas.remove_at(0)
		
		if(objectBeingCatched != null):
			objectBeingCatched.get_parent().remove_child(objectBeingCatched)
			add_child(objectBeingCatched)
			if(numberOfObjects == 0):
				objectBeingCatched.transform.origin = Vector2(0,-12)
			elif(numberOfObjects == 1):
				objectBeingCatched.transform.origin = Vector2(0,-22)
						
	numberOfObjects += 1
	print(numberOfObjects)
