extends CanvasLayer

func _ready() -> void:
	visible = false

func _on_restart_button_down() -> void:
	visible = false
	get_tree().reload_current_scene()
	

func _on_quit_button_down() -> void:
	get_tree().quit()
