extends CharacterBody2D

var speed = 300

func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed
	if event.is_action_pressed("left_click")

func _physics_process(delta):
	get_input()
	move_and_slide()
	
