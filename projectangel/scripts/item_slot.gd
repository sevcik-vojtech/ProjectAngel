extends VBoxContainer

signal button_down()

func _on_item_button_down() -> void:
	button_down.emit()
	pass # Replace with function body.
