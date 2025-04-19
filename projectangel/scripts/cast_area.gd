extends Area2D

@export var CD = 3.1
var cooldown = false
var LVL_spread = 0
var LVL_CDreduction = 0
var LVL_minigun = 0
var LVL_repeat = 0

func _ready() -> void:
	$CastCD.wait_time = CD


func _physics_process(delta):
	look_at(get_global_mouse_position())
	get_input()
	

func get_input():
	if Input.is_action_just_pressed("Debug_4"):
		lvl_up_cooldown()
	if Input.is_action_just_pressed("Debug_3"):
		lvl_up_minigun()
	if Input.is_action_just_pressed("Debug_2"):
		lvl_up_spread()
	if Input.is_action_just_pressed("Debug_5"):
		lvl_up_repeat()
	if !cooldown:
		if Input.is_action_pressed("left_click"): 
			print("pow")
			for j in LVL_repeat + 1:
				shoot()
				$RepeatCD.wait_time = 0.3 
				$RepeatCD.start(0.0)
				await $RepeatCD.timeout
			$CastCD.start(0.0)
			$Pivot/direction.frame = 0
			$Pivot/direction.play("default", 2)


func shoot():
	cooldown = true
	const PROJECTILE = preload("res://scenes/projectile_1.tscn")
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = %ShootingPoint.global_position
	new_projectile.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_projectile)
	for i in LVL_spread:
		var new_projectile1 = PROJECTILE.instantiate()
		new_projectile1.global_position = $Pivot.global_position + (%ShootingPoint.global_position - $Pivot.global_position).rotated(deg_to_rad(20 + 20 * i))
		new_projectile1.global_rotation = %ShootingPoint.global_rotation + (deg_to_rad(20 + 20 * i))
		%ShootingPoint.add_child(new_projectile1)
		var new_projectile2 = PROJECTILE.instantiate()
		new_projectile2.global_position = $Pivot.global_position + (%ShootingPoint.global_position - $Pivot.global_position).rotated(deg_to_rad(-20 -20 * i))
		new_projectile2.global_rotation = %ShootingPoint.global_rotation - (deg_to_rad(20 + 20 * i))
		%ShootingPoint.add_child(new_projectile2)
		print("pow")


func lvl_up_spread ():
	LVL_spread += 1
	print("spread lvled up")
func lvl_up_cooldown ():
	LVL_CDreduction += 1
func lvl_up_minigun ():
	LVL_minigun += 1
func lvl_up_repeat ():
	LVL_repeat += 1
	print("repeat lvled up ")


func _on_timer_timeout() -> void:
	cooldown = false
