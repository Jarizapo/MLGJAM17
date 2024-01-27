extends CharacterBody2D

var speed = 10.0

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
