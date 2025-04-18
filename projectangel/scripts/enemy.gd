extends RigidBody2D

@export var attack_range: float = 100.0
@export var attack_cooldown: float = 2.0

var player: Node2D = null
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
	player = get_tree().get_root().find_node("PlayerBody", true, false)

func _process(delta):
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		
		if distance_to_player <= attack_range and can_attack:
			attack_player()

func attack_player():
	# like a button press for player
	# if hurtbox intersepts player hitbox, player.take_damage(1)
	# $AnimatedSprite2D.play("attack")
	if can_attack:
		print("Enemy attacks the player")
		can_attack = false
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox"):
		area.take_damage(1)
