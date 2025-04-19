extends StaticBody2D

var health := 5

func _ready():
	add_to_group("altar")
	print(global_position)

func take_damage():
	health -= 1
	print("Altar hit, health remaining:", health)
	if health <= 0:
		die()

func die():
	print("Altar destroyed")
	var game_over = get_tree().get_current_scene().get_node("GameOverScreen")
	game_over.visible = true
	queue_free()
