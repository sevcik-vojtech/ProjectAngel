extends Area2D

@export var CD = 0.5
var cooldown = false
var is_in_range = false
var enemies_in_range

func _ready() -> void:
	$MeeleAttackCD.wait_time = CD

func _physics_process(delta):
	enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		if !cooldown:
			shoot()

			
			
func shoot():
	const MEELE = preload("res://scenes/meele_attack.tscn")
	var new_meele = MEELE.instantiate()
	new_meele.global_position = %MeeleAttackOrigin.global_position
	new_meele.global_rotation = %MeeleAttackOrigin.global_rotation
	%MeeleAttackOrigin.add_child(new_meele)
	cooldown = true
	$MeeleAttackCD.start(0.0)
	print("powpow")
	
	






func _on_meele_attack_cd_timeout() -> void:
	cooldown = false
