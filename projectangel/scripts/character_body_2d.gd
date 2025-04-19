extends CharacterBody2D

@export var speed = 50
const MAXHP = 3
var health = 3

func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed
	if Input.is_action_just_pressed("debug_take_damage"):
		take_damage()

	if Input.is_action_pressed("left_click"):
		print("left_click")
	if input_dir.length() != 0:
		$AnimatedSprite2D.play("run");
	else:
		$AnimatedSprite2D.play("idle");
	if (get_global_mouse_position() - get_global_transform().get_origin()).dot(Vector2(-1, 0)) > 0:
		$AnimatedSprite2D.flip_h = true;
	else:
		$AnimatedSprite2D.flip_h = false;
		
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
	
