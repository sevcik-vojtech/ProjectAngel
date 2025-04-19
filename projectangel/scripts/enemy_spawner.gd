extends Node2D

func random_position_on_circle(radius: float) -> Vector2:
	var angle = randf_range(0, TAU) 
	var offset = Vector2(cos(angle), sin(angle)) * radius
	return Vector2(1157.0, 645.0) + offset

func spawn_enemy():
	var enemy_scene = preload("res://scenes/enemy.tscn")
	var enemy = enemy_scene.instantiate()
	enemy.global_position = random_position_on_circle(1)
	add_child(enemy)
	print("Enemy spawned")

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
