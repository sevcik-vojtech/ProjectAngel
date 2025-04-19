extends Area2D
@export var damage = 10
@export var timeout = 0.2
@export var knockback_strenght = 1.0
func _ready() -> void:
	$MeeleAttackTimeout.wait_time = timeout
	$MeeleAttackTimeout.start(0.0)
	$MeeleAttackSprite.speed_scale = timeout/3
func _on_meele_attack_timeout_timeout() -> void:
	queue_free()
	



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(damage)
	
