extends StaticBody2D

var health := 100

func take_damage(amount: int):
	health -= amount
	print("Altar hit, health remaining:", health)
	if health <= 0:
		die()

func die():
	print("Altar destroyed")
	var game_over = get_tree().get_current_scene().get_node("GameOverScreen")
	game_over.visible = true
	queue_free()
