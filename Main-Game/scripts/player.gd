extends CharacterBody2D

enum Mode { BODY, MIND, SOUL}
var current_mode = Mode.BODY
var mode_name = ["BODY", "MIND", "SOUL"]

var jump_vel = 600
var speed = 300
var gravity = 980

@onready var sprite = $AnimatedSprite2D
@onready var state_label = $"../ColorRect/PlayerState"

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta * 2
		
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_vel
	
	var direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * speed
		sprite.scale.x = direction
	else:
		velocity.x = 0
	
	if Input.is_action_just_pressed("body_mode"):
		current_mode = Mode.BODY
	if Input.is_action_just_pressed("mind_mode"):
		current_mode = Mode.MIND
	if Input.is_action_just_pressed("soul_mode"):
		current_mode = Mode.SOUL
	
	match current_mode:
		Mode.BODY:
			handle_body_mode()
		Mode.SOUL:
			handle_soul_mode()
		Mode.MIND:
			handle_mind_mode()
	
	state_label.text = "MODE: %s\nVelocity: (%.0f, %.0f)" % [mode_name[current_mode], velocity.x, velocity.y]
	
	sprite_animation()
	

func handle_body_mode():
	jump_vel = 1000
	move_and_slide()

func handle_mind_mode():
	jump_vel = 2000
	move_and_slide()

func handle_soul_mode():
	jump_vel = 5000
	move_and_slide()

func sprite_animation():
	if is_on_floor():
		if velocity.x != 0:
			sprite.animation = "run"
		else:
			sprite.animation = "idle"
	
	else:
		if velocity.y < 0:
			sprite.animation = "jump"
		else:
			sprite.animation = "fall"
