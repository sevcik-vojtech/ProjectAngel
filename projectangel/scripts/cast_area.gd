extends Area2D

@export var CD = 3.1
var cooldown = false
var LVL_spread = 0
var LVL_CDreduction = 0
var LVL_minigun = 0
var LVL_repeat = 0
var LVL_damage = 0
var LVL_Canon = 0
var LVL_default = 0
var sizeMod = 1
var damageMod = 1
var knockbackMod = 1
var cdMod = 1
var cdMinigunMod = 1

func _ready() -> void:
	$CastCD.wait_time = CD


func _physics_process(delta):
	look_at(get_global_mouse_position())
	get_input()
	

func get_input():
	if Input.is_action_just_pressed("Debug_4"):
		lvl_up_canon()
		print("lvl up canon")
	if Input.is_action_just_pressed("Debug_3"):
		lvl_up_minigun()
		print("lvl up minigun")
	if Input.is_action_just_pressed("Debug_2"):
		lvl_up_spread()
		print("lvl up spread")
	if Input.is_action_just_pressed("Debug_5"):
		lvl_up_repeat()
		print("lvl up repeat")
	if !cooldown:
		if Input.is_action_pressed("left_click"): 
			print("pow")
			for j in LVL_repeat + 1:
				shoot()
				$RepeatCD.wait_time = 0.3 
				$RepeatCD.start(0.0)
				await $RepeatCD.timeout
			$CastCD.wait_time = CD * cdMod * cdMinigunMod
			$CastCD.start(0.0)
			$Pivot/direction.frame = 0
			$Pivot/direction.play("default", 2)


func shoot():
	cooldown = true
	const PROJECTILE = preload("res://scenes/projectile_1.tscn")
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = %ShootingPoint.global_position
	new_projectile.global_rotation = %ShootingPoint.global_rotation
	new_projectile.damage *= (1 + (0.1 * LVL_damage)) * damageMod
	new_projectile.scale = Vector2(sizeMod, sizeMod)
	new_projectile.knockback_strenght *= knockbackMod
	%ShootingPoint.add_child(new_projectile)
	for i in LVL_spread:
		var new_projectile1 = PROJECTILE.instantiate()
		new_projectile1.global_position = $Pivot.global_position + (%ShootingPoint.global_position - $Pivot.global_position).rotated(deg_to_rad(20 + 20 * i))
		new_projectile1.global_rotation = %ShootingPoint.global_rotation + (deg_to_rad(20 + 20 * i))
		new_projectile1.damage *= (1 + (0.1 * LVL_damage)) * damageMod
		new_projectile1.scale = Vector2(sizeMod, sizeMod)
		new_projectile1.knockback_strenght *= knockbackMod
		%ShootingPoint.add_child(new_projectile1)
		var new_projectile2 = PROJECTILE.instantiate()
		new_projectile2.global_position = $Pivot.global_position + (%ShootingPoint.global_position - $Pivot.global_position).rotated(deg_to_rad(-20 -20 * i))
		new_projectile2.global_rotation = %ShootingPoint.global_rotation - (deg_to_rad(20 + 20 * i))
		new_projectile2.damage *= (1 + (0.1 * LVL_damage)) * damageMod
		new_projectile2.scale = Vector2(sizeMod, sizeMod)
		new_projectile2.knockback_strenght *= knockbackMod
		%ShootingPoint.add_child(new_projectile2)
		print("pow")


func lvl_up_spread ():
	LVL_spread += 1
func lvl_up_cooldown ():
	LVL_CDreduction += 1
	if(LVL_minigun != 1 ):
		cdMod /= 1.1
	else:
		lvl_up_damage()
func lvl_up_minigun ():
	LVL_minigun = 1
	sizeMod = 0.5
	cdMod = CD * 0.02
	damageMod = 0.2
	knockbackMod = 0.5
func lvl_up_repeat ():
	LVL_repeat += 1
func lvl_up_damage ():
	LVL_damage += 1
func lvl_up_canon ():
	LVL_Canon = 1
	sizeMod = 3
	cdMod = 1.5
	damageMod = 4
	knockbackMod = 4
func lvl_up_default ():
	LVL_default = 1
	cdMod = 0.8
	damageMod = 1.5
	knockbackMod = 1.5


func _on_timer_timeout() -> void:
	cooldown = false
