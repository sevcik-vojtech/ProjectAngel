extends CharacterBody2D

@export var attack_range: float = 1.0
@export var attack_cooldown: float = 2.0

var player: CharacterBody2D = null
var can_attack: bool = true
var health := 100

func take_damage(amount: int):
	health -= amount
	print("Enemy hit, health remaining:", health)
	if health <= 0:
		die()

func die():
	print("Enemy defeated")
	queue_free()

func _ready():
	var _player = get_tree().get_nodes_in_group("player").front()
	$EnemyAnimation.play("default")
	add_to_group("enemy")

func _process(_delta):
	if $EnemyAnimation.frame == 2:
		$EnemyAnimation/Hitbox.monitoring = true;
	else:
		$EnemyAnimation/Hitbox.monitoring = false;
	
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		
		if distance_to_player <= attack_range and can_attack:
			attack_player()

func attack_player():
	$EnemyAnimation.play("attack_animation")
	can_attack = false
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		area.take_damage(1)
