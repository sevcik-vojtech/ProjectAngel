extends CharacterBody2D

var speed = 50

func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed
	if Input.is_action_pressed("left_click"):
		print("left_click")

func _physics_process(delta):
	get_input()
	move_and_slide()
	
