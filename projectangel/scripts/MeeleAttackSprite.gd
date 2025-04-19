extends AnimatedSprite2D


@onready var animated: AnimatedSprite2D = $"."

func _ready():
	animated.play("idle")
	
func _process(delta):
	pass
