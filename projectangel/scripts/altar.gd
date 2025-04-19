extends StaticBody2D

var max_hp = 10
var health = max_hp

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
	
func purchase_max_altar_health():
	max_hp += 2
	
func heal_to_full():
	health = max_hp


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Player entered")
	print($"../EnemySpawner".wave_over)
	print(body.is_in_group("player"))
	if $"../EnemySpawner".wave_over and body.is_in_group("player"):
		print("Player entered and wave over")
		$"../AltarShop".visible = true
