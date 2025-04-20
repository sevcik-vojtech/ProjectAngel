extends CanvasLayer

func _ready():
	$Panel/VBoxContainer/ItemSlot/ItemName.text = "Default"
	$Panel/VBoxContainer/ItemSlot2/ItemName.text = "Rapid Fire"
	$Panel/VBoxContainer/ItemSlot3/ItemName.text = "Blast"
	$Panel/VBoxContainer/ItemSlot/Button.text = "Pick"
	$Panel/VBoxContainer/ItemSlot2/Button.text = "Pick"
	$Panel/VBoxContainer/ItemSlot3/Button.text = "Pick"


func _on_item_slot_button_down() -> void:
	get_tree().get_first_node_in_group("player").pick_default()
	$"../EnemySpawner".spawn_enemy_wave()
	visible = false


func _on_item_slot_2_button_down() -> void:
	get_tree().get_first_node_in_group("player").pick_rapid()
	$"../EnemySpawner".spawn_enemy_wave()
	visible = false


func _on_item_slot_3_button_down() -> void:
	get_tree().get_first_node_in_group("player").pick_blast()
	$"../EnemySpawner".spawn_enemy_wave()
	visible = false


func _on_next_wave_button_down() -> void:
	$"../EnemySpawner".spawn_enemy_wave()
	visible = false
