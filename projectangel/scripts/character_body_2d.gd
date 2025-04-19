extends CharacterBody2D

@export var speed = 50
@export var dash_speed = 500
var can_take_damage = true
var is_dashing = false
var dash_is_on_cd = false
@export var dash_duration = 1.0

const MAXHP = 3
var health = 3

func _ready() -> void:
	add_to_group("player")


func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	if !is_dashing:
		velocity = input_dir * speed
	if Input.is_action_just_pressed("debug_take_damage"):
		take_damage()
	if input_dir.length() != 0:
		$AnimatedSprite2D.play("run");
	else:
		$AnimatedSprite2D.play("idle");
	if (get_global_mouse_position() - get_global_transform().get_origin()).dot(Vector2(-1, 0)) > 0:
		$AnimatedSprite2D.flip_h = true;
	else:
		$AnimatedSprite2D.flip_h = false;
	if Input.is_action_just_pressed("movement"):
		dash(input_dir)
		
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
	
func dash(input_dir):   
	if !dash_is_on_cd:
		dash_is_on_cd = true
		is_dashing = true
		can_take_damage = false
		velocity = input_dir * dash_speed
		$DashTimer.wait_time = dash_duration
		$DashTimer.start(0.0)
		await $DashTimer.timeout
		velocity = Vector2.ZERO
		is_dashing = false
		can_take_damage = true
		$DashCD.start(0.0)

func game_over():
	$"../GameOverScreen".visible = true
	queue_free()
	



	


func _on_dash_cd_timeout() -> void:
	dash_is_on_cd = false
	
