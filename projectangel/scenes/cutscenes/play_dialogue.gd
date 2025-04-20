extends Node2D

var resource;

func play_dialogue(dialogue : String, start : String):
	resource = load("res://resources/dialogues/" + dialogue + ".dialogue");
	DialogueManager.show_dialogue_balloon(resource, start)
