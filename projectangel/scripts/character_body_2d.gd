extends CharacterBody2D

var speed = 50
const MAXHP = 3
var health = 3


func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed
	if Input.is_action_just_pressed("debug_take_damage"):
		take_damage()

func _physics_process(delta):
	get_input()
	move_and_slide()
	
func take_damage():
	health -= 1
	if health == 0: 
		game_over()

func heal():
	if health != MAXHP:
		health += 1
	

func game_over():
	$"../GameOverScreen".visible = true
	queue_free()
	
