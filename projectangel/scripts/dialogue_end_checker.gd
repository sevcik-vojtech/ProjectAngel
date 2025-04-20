extends Node

var dialogue_finish = false; 

var main_loaded = false;

func _process(delta: float) -> void:
	if(dialogue_finish && !main_loaded):
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		main_loaded = true
