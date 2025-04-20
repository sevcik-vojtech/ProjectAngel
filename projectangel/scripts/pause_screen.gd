extends CanvasLayer

var opened:bool

func _ready():
	$Label.text = "MENU"
	opened = false

func _on_reset_button_button_down() -> void:
	visible = false
	get_tree().reload_current_scene()


func _on_quit_button_button_down() -> void:
	get_tree().quit()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		if(opened):
			visible = false
			opened = false
		else:
			visible = true
			opened = true
