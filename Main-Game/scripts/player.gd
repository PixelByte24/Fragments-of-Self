extends CharacterBody2D

var jump_vel = 100;
func _physics_process(delta):
	velocity.y = jump_vel
	
	move_and_slide()
