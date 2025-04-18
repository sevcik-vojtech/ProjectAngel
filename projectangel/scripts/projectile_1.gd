extends Area2D

@export var speed = 750
const RANGE = 5000
var travelled_distance = 0

func _physics_process(delta):
	var direction = Vector2.UP.rotated(rotation)
	position += direction * speed * delta
	
	travelled_distance += speed * delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
