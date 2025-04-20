extends Area2D

@export var duration = 5.05
@export var tickrate = 1.0
@export var damage = 5
var enemies_inside

func _ready() -> void:
	$Special_1_Duration.wait_time = duration
	$Special_1Tick.wait_time = tickrate
	$Special_1Tick.start(0.0)
	$Special_1_Duration.start(0.0)
	
	

func _physics_process(delta: float) -> void:
	enemies_inside = get_overlapping_bodies()


func _on_special_1_duration_timeout() -> void:
	queue_free()


func _on_tick_timeout() -> void:
	for i in enemies_inside.size():
		enemies_inside[i].take_damage(damage)
	get_tree().get_first_node_in_group("player").heal()
	$Special_1Tick.start(0.0)
