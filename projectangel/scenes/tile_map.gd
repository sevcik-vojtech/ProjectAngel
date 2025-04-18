@tool
extends TileMap

func _ready():
	if Engine.is_editor_hint():
		random_fill()

func random_fill():
	var tile_ids = [0, 1, 2]
	var area_width = 20
	var area_height = 15
	for x in area_width:
		for y in area_height:
			var tile_id = tile_ids[randi() % tile_ids.size()]
			set_cell(0, Vector2i(x, y), tile_id)
