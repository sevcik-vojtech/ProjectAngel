extends Label
var score: int = 0
@onready var score_label = $"."

func _ready():
	update_score_label(0)
	
func update_score_label(amount: int):
	score = amount
	score_label.text = "%d" % score
