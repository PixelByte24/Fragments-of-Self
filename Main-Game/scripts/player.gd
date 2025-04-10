extends CharacterBody2D

var jump_vel = 600
var speed = 300
var gravity = 980
var jump_pressed = false

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * 2 * delta
		
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		jump_pressed = true
		
	if jump_pressed:
		velocity.y = -jump_vel
	
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = 0
	
	sprite_animation(direction)
	move_and_slide()
 

func sprite_animation(direction):
	if is_on_floor():
		if velocity.x != 0:
			sprite.animation = "run"
			sprite.scale.x = direction
		else:
			sprite.animation = "idle"
	
	else:
		if velocity.y < 0:
			sprite.animation = "jump"
		else:
			sprite.animation = "fall"
	
