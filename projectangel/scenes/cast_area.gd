extends Area2D

var cooldown = false

func _physics_process(delta):
	look_at(get_global_mouse_position())
	get_input()
	

func get_input():
	if Input.is_action_pressed("left_click"):
		if !cooldown : 
			shoot()

func shoot():
	const PROJECTILE = preload("res://scenes/projectile_1.tscn")
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.global_position = %ShootingPoint.global_position
	new_projectile.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_projectile)
	cooldown = true
	
	
	


func _on_timer_timeout() -> void:
	cooldown = false
