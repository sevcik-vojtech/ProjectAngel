extends CharacterBody2D

@onready var damage_numbers_origin = $Marker2D
var player: CharacterBody2D = null
var can_attack: bool = true
var health := 10
var area_is_in_hitbox: bool = false
var area_in_hitbox: Area2D = null
var mvnt_speed = 25
var knockback_speed = 150
var is_knocked_back: bool = false


func take_damage(amount: int):
	health -= amount
	DamageNumbers.display_numbers(amount, damage_numbers_origin.global_position, "#B22", 16)
	print("Enemy hit, health remaining:", health)
	if health <= 0:
		die()

func get_knockback(strength: float, direction: Vector2):
	velocity = direction * knockback_speed * strength
	is_knocked_back = true
	$KnockbackDuration.start()

func die():
	print("Enemy defeated")
	get_tree().get_first_node_in_group("player").increment_cash(20)
	queue_free()

func _ready():
	$EnemyAnimation.play("default")
	add_to_group("enemy")
	scale = Vector2(0.7, 0.7)

func _process(_delta):
	if !is_knocked_back:
		var direction_to_altar = (Vector2(1157.0, 645.0) - global_position).normalized()
		velocity = direction_to_altar * mvnt_speed
	
	if area_is_in_hitbox:
		if (area_in_hitbox.get_parent().is_in_group("player") or area_in_hitbox.get_parent().is_in_group("altar")) and can_attack:
			$EnemyAnimation.play("attack_animation")
			
		if (area_in_hitbox.get_parent().is_in_group("player") or area_in_hitbox.get_parent().is_in_group("altar")) and can_attack and $EnemyAnimation.frame == 2:
			area_in_hitbox.get_parent().take_damage()
			print("Enemy Attaking")
			can_attack = false
			$AttackCooldown.start()

func _physics_process(_delta):
	move_and_slide()

func _on_hitbox_area_entered(area: Area2D) -> void:
	area_is_in_hitbox = true
	area_in_hitbox = area

func _on_hitbox_area_exited(area: Area2D) -> void:
	area_is_in_hitbox = false
	$EnemyAnimation.play("default")


func _on_attack_cooldown_timeout() -> void:
	can_attack = true

func _on_enemy_animation_finished() -> void:
	$EnemyAnimation.play("default")


func _on_knockback_duration_timeout() -> void:
	is_knocked_back = false
