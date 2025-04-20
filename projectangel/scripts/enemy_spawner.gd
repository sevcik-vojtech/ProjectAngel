extends Node2D

var enemies_spawned
var wave_num: int
var wave_over: bool = true
var enemies_to_slain: int

@export var basic_enemies_to_be_spawned: int
@export var fast_enemies_to_be_spawned: int
@export var big_enemies_to_be_spawned: int


func _ready():
	enemies_spawned = 0
	wave_num = 0
	wave_over = true;
	add_to_group("spawner")
	#spawn_enemy_wave()
	#spawn_enemy(0, 300)
	#spawn_enemy(1, 300)
	#spawn_enemy(2, 300)

func _process(_delta: float) -> void:
	if enemies_to_slain == 0:
		$"../Altar".enemiesSlain = true

func random_position_on_circle(radius: float) -> Vector2:
	var angle = randf_range(0, TAU) 
	var offset = Vector2(cos(angle), sin(angle)) * radius
	return Vector2(0.0, 0.0) + offset

func spawn_enemy(type: int, radius: float):
	if type == 0:
		var enemy_scene = preload("res://scenes/enemy.tscn")
		var enemy = enemy_scene.instantiate()
		enemy.global_position = random_position_on_circle(radius)
		add_child(enemy)
		print("Enemy spawned")
	if type == 1:
		var enemy_scene = preload("res://scenes/enemy_fast.tscn")
		var enemy = enemy_scene.instantiate()
		enemy.global_position = random_position_on_circle(radius)
		add_child(enemy)
		print("Enemy spawned")
	if type == 2:
		var enemy_scene = preload("res://scenes/enemy_big.tscn")
		var enemy = enemy_scene.instantiate()
		enemy.global_position = random_position_on_circle(radius)
		add_child(enemy)
		print("Enemy spawned")

func spawn_enemy_wave():
	$"../Altar".enemiesSlain = false
	wave_over = false
	wave_num += 1
	enemies_to_slain = 0
	$"../UI".update_wave_num(wave_num)
	print("Wave " + str(wave_num) + " started")
	basic_enemies_to_be_spawned = wave_num * 10
	fast_enemies_to_be_spawned = wave_num * 1
	if(wave_num % 5 == 0):
		big_enemies_to_be_spawned = wave_num / 5
	else:
		big_enemies_to_be_spawned = 0
	
	enemies_to_slain += basic_enemies_to_be_spawned
	enemies_to_slain += fast_enemies_to_be_spawned
	enemies_to_slain += big_enemies_to_be_spawned
	$SpawnTimer.start()


func _on_spawn_timer_timeout() -> void:
	if big_enemies_to_be_spawned > 0:
		spawn_enemy(2, 700)
		big_enemies_to_be_spawned -= 1
	else: 
		if (basic_enemies_to_be_spawned < (fast_enemies_to_be_spawned * 10)) and fast_enemies_to_be_spawned > 0:
			spawn_enemy(1, 700)
			fast_enemies_to_be_spawned -= 1
		else: 
			if basic_enemies_to_be_spawned > 0:
				spawn_enemy(0, 700)
				basic_enemies_to_be_spawned -= 1
	
	if basic_enemies_to_be_spawned == 0 and fast_enemies_to_be_spawned == 0 and big_enemies_to_be_spawned == 0:
		#wave_num = wave_num + 1
		#print("Wave" + str(wave_num))
		wave_over = true
	else:
		$SpawnTimer.start()
