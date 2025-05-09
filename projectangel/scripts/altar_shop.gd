extends CanvasLayer
var price = 50
var itemList

var all_items = [
	{"name": "Projectile count", "price": price, "on_purchase": func(): get_tree().get_first_node_in_group("player").purchase_projectyle_count()},
	{"name": "Burst", "price": price, "on_purchase": func(): get_tree().get_first_node_in_group("player").purchase_burst()},
	{"name": "Fire speed", "price": price, "on_purchase": func(): get_tree().get_first_node_in_group("player").purchase_fire_speed()},
	{"name": "Damage", "price": price, "on_purchase": func(): get_tree().get_first_node_in_group("player").purchase_damage()},
	{"name": "Regeneration", "price": price, "on_purchase": func(): get_tree().get_first_node_in_group("player").purchase_regen()},
	{"name": "Movement speed", "price": price, "on_purchase": func(): get_tree().get_first_node_in_group("player").purchase_mvnt_speed()},
	{"name": "Max Health", "price": price, "on_purchase": func(): get_tree().get_first_node_in_group("player").purchase_max_health()},
	{"name": "Max Altar Health", "price": price, "on_purchase": func(): get_tree().get_first_node_in_group("altar").purchase_max_altar_health()},
	{"name": "Ability Size", "price": price, "on_purchase": func(): get_tree().get_first_node_in_group("player").purchase_ability_size()},
	{"name": "Ability Cooldown", "price": price, "on_purchase": func(): get_tree().get_first_node_in_group("player").purchase_ability_cooldown()}
]

func get_shop_items():
	var shuffled = all_items.duplicate()
	shuffled.shuffle()
	return shuffled.slice(0, 4)


func populate_shop():
	itemList = get_shop_items()
	$Panel/VBoxContainer/ItemSlot/ItemName.text = itemList[0]["name"]
	$Panel/VBoxContainer/ItemSlot/Button.text = str(price) + " souls"
	
	$Panel/VBoxContainer/ItemSlot2/ItemName.text = itemList[1]["name"]
	$Panel/VBoxContainer/ItemSlot2/Button.text = str(price) + " souls"
	
	$Panel/VBoxContainer/ItemSlot3/ItemName.text = itemList[2]["name"]
	$Panel/VBoxContainer/ItemSlot3/Button.text = str(price) + " souls"
	
	$Panel/VBoxContainer/ItemSlot4/ItemName.text = itemList[3]["name"]
	$Panel/VBoxContainer/ItemSlot4/Button.text = str(price) + " souls"


func _on_item_slot1_button_down() -> void:
	if get_tree().get_first_node_in_group("player").cash >= price:
		get_tree().get_first_node_in_group("player").pay(price)
		price += 20
		populate_shop()
		itemList[0]["on_purchase"].call()


func _on_item_slot2_button_down() -> void:
	if get_tree().get_first_node_in_group("player").cash >= price:
		get_tree().get_first_node_in_group("player").pay(price)
		price += 20
		populate_shop()
		itemList[1]["on_purchase"].call()


func _on_item_slot3_button_down() -> void:
	if get_tree().get_first_node_in_group("player").cash >= price:
		get_tree().get_first_node_in_group("player").pay(price)
		price += 20
		populate_shop()
		itemList[2]["on_purchase"].call()


func _on_item_slot4_button_down() -> void:
	if get_tree().get_first_node_in_group("player").cash >= price:
		get_tree().get_first_node_in_group("player").pay(price)
		price += 20
		populate_shop()
		itemList[3]["on_purchase"].call()


func _on_next_wave_button_down() -> void:
	$"../Altar".enemiesSlain = false
	$"../EnemySpawner".spawn_enemy_wave()
	visible = false
