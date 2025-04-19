extends Area2D

@export var speed = 750
@export var damage = 10
const RANGE = 5000
var travelled_distance = 0
@export var knockback_strenght = 0.5

func _physics_process(delta):
	var direction = Vector2.UP.rotated(rotation)
	position += direction * speed * delta
	
	travelled_distance += speed * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		body.get_knockback(knockback_strenght, (-global_position + body.global_position).normalized())
	queue_free()
