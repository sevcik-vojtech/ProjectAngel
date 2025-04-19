extends CharacterBody2D

var player: CharacterBody2D = null
var can_attack: bool = true
var health := 100
var area_is_in_hitbox: bool = false
var area_in_hitbox: Area2D = null
var mvnt_speed = 25


func take_damage(amount: int):
	health -= amount
	print("Enemy hit, health remaining:", health)
	if health <= 0:
		die()

func die():
	print("Enemy defeated")
	queue_free()

func _ready():
	$EnemyAnimation.play("default")
	add_to_group("enemy")

func _process(_delta):

	var direction_to_altar = (Vector2(1157.0, 645.0) - global_position).normalized()
	velocity = direction_to_altar * mvnt_speed
	
	if area_is_in_hitbox:
		if (area_in_hitbox.get_parent().is_in_group("player") or area_in_hitbox.get_parent().is_in_group("altar")) and can_attack:
			$EnemyAnimation.play("attack_animation")
			
		if (area_in_hitbox.get_parent().is_in_group("player") or area_in_hitbox.get_parent().is_in_group("altar")) and can_attack and $EnemyAnimation.frame == 2:
			area_in_hitbox.get_parent().take_damage()
			print("Attaking")
			can_attack = false
			$AttackCooldown.start()

func _physics_process(delta):
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
